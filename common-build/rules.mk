# Licensed to Crate.io GmbH ("Crate") under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  Crate licenses
# this file to you under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.  You may
# obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
# License for the specific language governing permissions and limitations
# under the License.
#
# However, if you have executed another commercial license agreement
# with Crate these terms will supersede the license and you may use the
# software solely pursuant to the terms of the relevant commercial agreement.


# =============================================================================
# Core build system
# =============================================================================

# This Make script implements the core of the Crate Docs build system.

# All Sphinx projects that use the Crate Docs build system contain a `Makefile`
# (copied from `docs/Makefile` in this project) with a boilerplate section
# responsible making a local copy of the Crate Docs project and integrating
# with the core build system.

# Each project-specific `Makefile` runs this script with a submake, effectively
# functioning as as lightweight wrapper.

# All variables defined in the `Makefile` (e.g., `TOP_DIR`, and `DOCS_DIR`) are
# exported and available for use in this script.


# Variable setup
# =============================================================================

.EXPORT_ALL_VARIABLES:

LOCAL_DIR       = $(patsubst %/common-build/,%,$(dir $(lastword $(MAKEFILE_LIST))))
SRC_DIR         = $(LOCAL_DIR)/common-build
BIN_DIR         = $(SRC_DIR)/bin
ENV_DIR         = $(LOCAL_DIR)/.venv
ACTIVATE        = $(ENV_DIR)/bin/activate
PYTHON          = python3
PIP             = $(PYTHON) -m pip
SPHINXBUILD     = $(ENV_DIR)/bin/sphinx-build
SPHINXAUTOBUILD = $(ENV_DIR)/bin/sphinx-autobuild
AUTOBUILD_OPTS  = --watch $(TOP_DIR)/src --re-ignore '^(?!.+\.(?:rst|md|mmd|html|css|js|py|conf)$$)' --open-browser --delay 0
BUILD_DIR       = $(LOCAL_DIR)/.build
SPHINX_ARGS     = . $(BUILD_DIR)
SPHINX_OPTS     = -W -n
SPHINX_OPTS_CI  = --keep-going
RST2HTML        = $(ENV_DIR)/bin/rst2html.py
TELEMETRY_DIR   = $(LOCAL_DIR)/telemetry
VALE_VERSION    = 2.6.7
ERRATA_AI       = https://github.com/errata-ai
VALE_URL_PREFIX = $(ERRATA_AI)/vale/releases/download
VALE_URL        = $(VALE_URL_PREFIX)/v$(VALE_VERSION)
VALE_LINUX      = vale_$(VALE_VERSION)_Linux_64-bit.tar.gz
VALE_MACOS      = vale_$(VALE_VERSION)_macOS_64-bit.tar.gz
VALE_WIN        = vale_$(VALE_VERSION)_Windows_64-bit.tar.gz
VALE_PROSELINT  = $(ERRATA_AI)/proselint/archive/v0.3.2.tar.gz
VALE_WRITEGOOD  = $(ERRATA_AI)/write-good/archive/v0.4.0.tar.gz
                  # Vale disabled if exists
NO_VALE_FILE    = $(TOP_DIR)/$(DOCS_DIR)/_no_vale
TOOLS_DIR       = $(LOCAL_DIR)/tools
STYLE_DIR       = $(LOCAL_DIR)/tools/styles
                  # Ignore RST files matching these globs (space separated)
GLOBS           = */.* */style/* */site-packages/* */eggs/* */vendor/*
                  # Package globs for the `find` program
FIND_OPTS       = $(foreach glob,$(GLOBS),-path '$(glob)' -prune -o)
FIND_RST        = cd $(TOP_DIR) && find . $(FIND_OPTS) -name '*.rst' -print
VALE            = $(TOOLS_DIR)/vale
                  # Package globs for Vale
VALE_GLOBS      = $(shell echo '$(GLOBS)' | sed 's, ,\,,g')
VALE_OPTS       = --config=$(SRC_DIR)/_vale.ini --no-exit \
                      --glob='!{$(VALE_GLOBS)}'
JQ              = $(TOOLS_DIR)/jq
JQ_OPTS         = --from-file
JQ_FILE_JSON    = $(BIN_DIR)/vale-json.jq
JQ_FILE_CSV     = $(BIN_DIR)/vale-json-csv.jq
VALE_OUT_DIR    = $(TELEMETRY_DIR)/vale
GIT_LOG         = $(BIN_DIR)/git-log
GIT_LOG_OUT_DIR = $(TELEMETRY_DIR)/git-log

# Figure out the OS
ifeq ($(findstring ;,$(PATH)),;)
    # Windows, but not POSIX environment
else
    UNAME := $(shell uname 2>/dev/null || echo Unknown)
    UNAME := $(patsubst CYGWIN%,Windows,$(UNAME))
    UNAME := $(patsubst MSYS%,Windows,$(UNAME))
    UNAME := $(patsubst MINGW%,Windows,$(UNAME))
endif

# Disable Vale if `$(NO_VALE_FILE)` exists
ifneq ($(wildcard $(NO_VALE_FILE)),)
    UNAME := none
endif


# Help message
# =============================================================================

.PHONY: help
help:
	@ printf '\033[1mCrate Docs\033[00m\n'
	@ echo
	@ printf 'Run `make <TARGET>`, where <TARGET> is one of:\n'
	@ echo
	@ printf '\033[1m  dev        \033[00m Run a live HTML preview that '
	@ printf                               'automatically refreshes the web\n'
	@ printf '\033[1m             \033[00m browser as you edit the source '
	@ printf                               'files\n'
	@ echo
	@ printf '\033[1m  html       \033[00m Build the static HTML files\n'
	@ echo
	@ printf '\033[1m  check      \033[00m Build, test, and lint the'
	@ printf                              ' documentation\n'
	@ echo
	@ printf '\033[1m  telemetry  \033[00m Generate the QA telemetry data\n'
	@ echo
	@ printf '\033[1m  reset      \033[00m Reset the build system\n'


# Environment bootstrapping
# =============================================================================

# Check Python version and create a virtual environment
$(ACTIVATE):
	@ printf '\033[1mCreating a Python virtual environment...\033[00m\n'
	@ if ! $(PYTHON) -c 'import sys; assert sys.version_info >= (3, 7)'; then \
	      printf '\033[31mERROR: Python>=3.7 is required.\033[00m\n'; \
	      exit 1; \
	  fi
	@ $(PYTHON) -m venv $(ENV_DIR)
	@ . $(ACTIVATE) && \
	      $(PIP) install --upgrade pip

# Install dependencies needed by these three tools
$(RST2HTML) $(SPHINXBUILD) $(SPHINXAUTOBUILD): $(ACTIVATE)
	@ printf '\033[1mInstalling Python dependencies...\033[00m\n'
	@ . $(ACTIVATE) && \
	      $(PIP) install -r $(SRC_DIR)/requirements.txt
	@ # Change to `TOP_DIR` to mimic how Read the Docs does it
	@ . $(ACTIVATE) && cd $(TOP_DIR) && \
	      $(PIP) install -r $(DOCS_DIR)/requirements.txt

# Configured and run in a sub-make by the $(VALE) target
install-vale:
	@ mkdir -p $(TOOLS_DIR)
	@ printf '\033[1mDownloading Vale...\033[00m\n'
	@ if ! curl --fail --location $(VALE_URL)/$(PROGRAM) \
	      --output $(TOOLS_DIR)/$(PROGRAM); then \
	      printf '\033[31mERROR: Downloading Vale failed.\033[00m\n'; \
	      exit 1; \
	  fi
	@ cd $(TOOLS_DIR) && tar -xzf $(PROGRAM)

# Configured and run in a sub-make by the $(VALE) target
install-vale-styles:
	@ mkdir -p $(STYLE_DIR)
	@ printf '\033[1mDownloading proselint styles...\033[00m\n'
	@ curl --location $(VALE_PROSELINT) | \
	      tar -C $(STYLE_DIR) -xz \
	      --strip-components=1 $(TAR_OPTS) '*/proselint'
	@ printf '\033[1mDownloading write-good styles...\033[00m\n'
	@ curl --location $(VALE_WRITEGOOD) | \
	      tar -C $(STYLE_DIR) -xz \
	      --strip-components=1 $(TAR_OPTS) '*/write-good'

# Vale installation for GNU/Linux
ifeq ($(UNAME),Linux)
$(VALE):
	@ $(MAKE) install-vale PROGRAM=$(VALE_LINUX)
	@ $(MAKE) install-vale-styles TAR_OPTS=--wildcards
endif

# Vale installation for macOS
ifeq ($(UNAME),Darwin)
$(VALE):
	@ $(MAKE) install-vale PROGRAM=$(VALE_MACOS)
	@ $(MAKE) install-vale-styles
endif


# Core build commands and QA checks
# =============================================================================

# If you are having problems with the `linkcheck` target, you might
# want to configure `linkcheck_ignore` in your `conf.py` file.
.PHONY: html linkcheck
html linkcheck: $(ACTIVATE) $(SPHINXBUILD)
	@ . $(ACTIVATE) && \
	      $(SPHINXBUILD) \
	      $(SPHINX_ARGS) $(SPHINX_OPTS) $(SPHINX_OPTS_CI) -b $(@) $(O)

# Both target names will work
.PHONY: dev autobuild
dev autobuild: $(SPHINXAUTOBUILD)
	@ . $(ACTIVATE) && \
	      $(SPHINXAUTOBUILD) \
	      $(SPHINX_ARGS) $(SPHINX_OPTS) $(AUTOBUILD_OPTS) $(O)

# Lint RST files and echo the results (for users and CI/CD logs)
.PHONY: lint
ifeq ($(UNAME),none)
vale:
	@ printf '\033[31mERROR: No rules to install Vale on your operating '
	@ printf 'system or disabled by _no_vale file.\033[00m\n'
else
vale: $(ACTIVATE) $(VALE)
	@ mkdir -p $(@D)
	@ . $(ACTIVATE) && \
	      $(VALE) $(VALE_OPTS) $(TOP_DIR)
endif

# Both target names will work
.PHONY: check test
check test: html linkcheck vale


# Telemetry data
# =============================================================================

# Prepare the build environment, then make `telemetry-deps` (kicking off
# telemetry data generation)
.PHONY: qa
telemetry:
	@ # Remove directory to ensure `make telemetry` always regenerates the
	@ # telemetry data
	@ rm -rf $(TELEMETRY_DIR)
	@ # Pre-build dependencies so the output text is easier to read
	@ if test ! -f $(ACTIVATE); then \
	      $(MAKE) $(ACTIVATE); \
	  fi
	@ if test ! -f $(VALE); then \
	      $(MAKE) $(VALE); \
	  fi
	@ $(MAKE) telemetry-deps

# Make all telemetry targets (listed as prerequisites)
.PHONY: telemetry-deps
telemetry-deps: vale-data git-log-data


# Vale
# -----------------------------------------------------------------------------

# Print a status message then make the first file in the Vale telemetry data
# dependency graph
.PHONY: vale-data
vale-data:
	@ printf '\033[1mGenerating Vale data...\033[00m\n'
	@ $(MAKE) $(VALE_OUT_DIR)/summary.csv

# Symlink `jq` to our `tools` directory (makes it easier to fit this check into
# the dependency graph
$(JQ):
	@ mkdir -p $(@D)
	@ if ! ln -s `which jq` $(JQ); then \
	      printf '\033[31mERROR: The `$(JQ)` program is not on your '; \
	      printf '$PATH.\033[00m'; \
	      exit 1; \
	  fi

# Produce a CSV summary from the JSON summary
$(VALE_OUT_DIR)/summary.csv: $(VALE_OUT_DIR)/summary.json $(JQ)
	@ mkdir -p $(@D)
	@ cat $< | \
	      $(JQ) $(JQ_OPTS) $(JQ_FILE_CSV) --raw-output \
	      > $@
	@ printf 'Written: $@\n'

# Produce a JSON summary from the lint report
$(VALE_OUT_DIR)/summary.json: $(VALE_OUT_DIR)/report.json $(JQ)
	@ mkdir -p $(@D)
	@ cat $< | \
	      $(JQ) $(JQ_OPTS) $(JQ_FILE_JSON) \
	      > $@
	@ printf 'Written: $@\n'

# Lint RST files and write the lint report to a file (later used for generating
# summary data)
$(VALE_OUT_DIR)/report.json: $(ACTIVATE) $(VALE)
	@ mkdir -p $(@D)
	@ . $(ACTIVATE) && \
	      $(VALE) $(VALE_OPTS) --output=JSON $(TOP_DIR) > $@
	@ printf 'Written: $@\n'


# Git
# -----------------------------------------------------------------------------

# Find eligible RST files
rst_files := $(sort $(shell $(FIND_RST)))

# Construct `GIT_DIR` targets from RST files
git_log_rst = $(patsubst ./%,$(GIT_LOG_OUT_DIR)/%,$(rst_files))
git_log_csv = $(patsubst %.rst,%.csv,$(git_log_rst))

# Print a status message then make `git-log-deps` to avoid passing
# `$(git_log_csv)` directly to `$(MAKE)` (see below)
.PHONY: git-log-data
git-log-data:
	@ printf '\033[1mGenerating git-log data...\033[00m\n'
	@ $(MAKE) git-log-deps

# This target exists so that `$(git_log_csv)` can be specified as a
# prerequisite instead of being passed to `$(MAKE)`. This is done because
# `$(git_log_csv)` is a list of variable length that could excede `ARG_MAX`.
.PHONY: git-log-deps
git-log-deps: $(git_log_csv)

# Produce a metadata report (CSV)
$(GIT_LOG_OUT_DIR)/%.csv: ../%.rst
	@ mkdir -p $(@D)
	@ $(GIT_LOG) $< $@
	@ printf 'Written: $@\n'
