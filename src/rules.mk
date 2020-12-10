# Licensed to Crate (https://crate.io) under one or more contributor license
# agreements.  See the NOTICE file distributed with this work for additional
# information regarding copyright ownership.  Crate licenses this file to you
# under the Apache License, Version 2.0 (the "License"); you may not use this
# file except in compliance with the License.  You may obtain a copy of the
# License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations under
# the License.
#
# However, if you have executed another commercial license agreement with Crate
# these terms will supersede the license and you may use the software solely
# pursuant to the terms of the relevant commercial agreement.


.EXPORT_ALL_VARIABLES:

LOCAL_DIR       := $(patsubst %/src/,%,$(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR         := $(LOCAL_DIR)/src
ENV_DIR         := $(LOCAL_DIR)/.venv
ACTIVATE        := $(ENV_DIR)/bin/activate
PYTHON          := python3
PIP             := $(PYTHON) -m pip
SPHINXBUILD     := $(ENV_DIR)/bin/sphinx-build
SPHINXAUTOBUILD := $(ENV_DIR)/bin/sphinx-autobuild
AUTOBUILD_OPTS  := --re-ignore '^(?!.+\.rst$$)'
BUILD_DIR       := $(LOCAL_DIR)/.build
SPHINX_ARGS     := . $(BUILD_DIR)
SPHINX_OPTS     := -W -n
RST2HTML        := $(ENV_DIR)/bin/rst2html.py
VALE_VERSION    := 1.4.2
VALE_URL        := https://github.com/errata-ai/vale/releases/download
VALE_URL        := $(VALE_URL)/v$(VALE_VERSION)
VALE_LINUX      := vale_$(VALE_VERSION)_Linux_64-bit.tar.gz
VALE_MACOS      := vale_$(VALE_VERSION)_macOS_64-bit.tar.gz
VALE_WIN        := vale_$(VALE_VERSION)_Windows_64-bit.tar.gz
NO_VALE_FILE    := $(TOP_DIR)/$(DOCS_DIR)/_no_vale # Vale disabled if exists
TOOLS_DIR       := $(LOCAL_DIR)/tools
VALE            := $(TOOLS_DIR)/vale
VALE_OPTS       := --config=$(SRC_DIR)/_vale.ini --glob='!{**.git/**,**.venv/**}' --no-exit
LINT_DIR        := $(LOCAL_DIR)/lint
GIT_LOG         := $(SRC_DIR)/bin/git-log
QA_DIR          := $(LOCAL_DIR)/qa/$(DOCS_DIR)

# Figure out the OS
ifeq ($(findstring ;,$(PATH)),;)
    # Windows, but not POSIX environment
else
    UNAME := $(shell uname 2>/dev/null || echo Unknown)
    UNAME := $(patsubst CYGWIN%,Windows,$(UNAME))
    UNAME := $(patsubst MSYS%,Windows,$(UNAME))
    UNAME := $(patsubst MINGW%,Windows,$(UNAME))
endif

# Disable Vale
ifneq ($(wildcard $(NO_VALE_FILE)),)
   UNAME := none
endif

# Find all RST source files in `TOP_DIR` (but skip possible locations of
# third-party dependencies)
source_files := $(sort $(shell \
    find '$(TOP_DIR)' \
        -not -path '*/\.*' \
        -not -path '*/site-packages/*' \
        -name '*\.rst' \
        -type f))

# Generate targets
git_log_targets := $(patsubst %.rst,%.git-log.csv,$(patsubst %,$(QA_DIR)/%,$(source_files)))

.PHONY: help
help:
	@ printf '\033[33mCrate Docs Build\033[00m\n'
	@ echo
	@ printf 'Run `make <TARGET>`, where <TARGET> is one of:\n'
	@ echo
	@ printf '\033[37m  dev    \033[00m Run a Sphinx development server that builds\n'
	@ printf '\033[37m         \033[00m the documentation as you edit the source files\n'
	@ echo
	@ printf '\033[37m  html   \033[00m Build the static HTML output\n'
	@ echo
	@ printf '\033[37m  check  \033[00m Build, test, and lint the'
	@ printf                          ' documentation\n'
	@ echo
	@ printf '\033[37m  qa     \033[00m Generate QA telemetry\n'
	@ echo
	@ printf '\033[37m  reset  \033[00m Reset the build\n'

$(ACTIVATE):
	@# Check Python version. Currently, this asserts Python>=3.7.
	@$(PYTHON) -c 'import sys; assert sys.version_info >= (3, 7), "Requires Python>=3.7"'
	@# Create Python virtualenv
	$(PYTHON) -m venv $(ENV_DIR)
	. $(ACTIVATE) && \
	    $(PIP) install --upgrade pip

$(RST2HTML) $(SPHINXBUILD) $(SPHINXAUTOBUILD): $(ACTIVATE)
	. $(ACTIVATE) && \
	    $(PIP) install -r $(SRC_DIR)/requirements.txt
	@ # We change to `TOP_DIR` to mimic how Read the Docs does it
	. $(ACTIVATE) && cd $(TOP_DIR) && \
	    $(PIP) install -r $(DOCS_DIR)/requirements.txt

ifeq ($(UNAME),Linux)
$(VALE):
	$(MAKE) install-vale PROGRAM=$(VALE_LINUX)
endif

ifeq ($(UNAME),Darwin)
$(VALE):
	$(MAKE) install-vale PROGRAM=$(VALE_MACOS)
endif

install-vale:
	mkdir -p $(TOOLS_DIR)
	curl --fail --location $(VALE_URL)/$(PROGRAM) \
	    --output $(TOOLS_DIR)/$(PROGRAM) || \
	    (echo; echo ERROR: Downloading Vale failed && exit 1)
	cd $(TOOLS_DIR) && tar -xzf $(PROGRAM)

# Disable Vale by mocking the executable
ifeq ($(UNAME),none)
$(VALE):
	mkdir -p $(TOOLS_DIR)
	ln -s `which true` $(VALE)
endif

.PHONY: vale
vale: $(ACTIVATE) $(VALE)
	@ if test ! -x $(VALE); then \
	    printf 'No rules to install Vale on your operating system.\n'; \
	    exit 1; \
	fi
	@ # Force an empty line after environment setup and before linting happens
	@ # when running `make dev` for the first time
	@ echo

$(LINT_DIR):
	@ mkdir -p $(LINT_DIR)

.PHONY: lint-deps
lint-deps: $(LINT_DIR) vale

.PHONY: lint
lint: lint-deps

	@# Run linter for humans.
	. $(ACTIVATE) && $(VALE) $(VALE_OPTS) $(TOP_DIR)

	@# Run linter for machines, generate "report.json".
	. $(ACTIVATE) && $(VALE) $(VALE_OPTS) --output=JSON $(TOP_DIR) \
	    > $(LINT_DIR)/report.json

	@ if test $(shell which jq); then \
	    $(MAKE) lint-summary; \
	else \
	    echo; \
	    echo "INFO: For summarizing Vale output, please install the 'jq' program"; \
	    echo; \
	fi

lint-summary:

	@# Summarize "report.json" to "summary.json".
	@cat $(LINT_DIR)/report.json \
	    | jq --from-file $(SRC_DIR)/bin/vale-summary.jq \
	    > $(LINT_DIR)/summary.json

	@# Reformat "summary.json" to "summary.csv"
	@cat $(LINT_DIR)/summary.json \
	    | jq --from-file $(SRC_DIR)/bin/vale-summary2csv.jq --raw-output \
	    > $(LINT_DIR)/summary.csv

	@# Output reports, with colors.
	@cat $(LINT_DIR)/summary.json | jq .
	@cat $(LINT_DIR)/summary.csv

# If you are having problems with the `linkcheck` target, you might
# want to configure `linkcheck_ignore` in your `conf.py` file.
.PHONY: html linkcheck
html linkcheck: $(ACTIVATE) $(SPHINXBUILD)
	. $(ACTIVATE) && \
	    $(SPHINXBUILD) $(SPHINX_ARGS) $(SPHINX_OPTS) -b $(@) $(O)

.PHONY: autobuild-deps
autobuild-deps: $(SPHINXAUTOBUILD)

.PHONY: autobuild
autobuild: autobuild-deps
	. $(ACTIVATE) && \
	    $(SPHINXAUTOBUILD) $(SPHINX_ARGS) $(SPHINX_OPTS) $(AUTOBUILD_OPTS) $(O)

.PHONY: dev
dev: autobuild

.PHONY: check
check: html linkcheck lint

# Alias for commonly used Make target
.PHONY: test
test: check

$(QA_DIR):
	@ mkdir -p $(QA_DIR)

.PHONY: qa-deps
qa-deps: $(QA_DIR)

# Generate QA telemetry for a file
$(QA_DIR)/%.git-log.csv: %.rst
	@ if test -n '$(dir $@)'; then \
	    mkdir -p '$(dir $@)'; \
	fi
	@ $(GIT_LOG) '$<' '$@'

.PHONY: qa
qa: qa-deps $(git_log_targets)
	@ # Do not error out when linting for QA telemetry
	@ VALE_NO_EXIT=1 $(MAKE) check
