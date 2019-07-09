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

LOCAL_DIR    := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
ENV_DIR      := $(LOCAL_DIR)/.env
ACTIVATE     := $(ENV_DIR)/bin/activate
PYTHON       := python3.7
PIP          := $(PYTHON) -m pip
RST2HTML     := rst2html.py
VALE_VERSION := 1.4.2
VALE_URL     := https://github.com/errata-ai/vale/releases/download
VALE_URL     := $(VALE_URL)/v$(VALE_VERSION)
VALE_LINUX   := vale_$(VALE_VERSION)_Linux_64-bit.tar.gz
VALE_MACOS   := vale_$(VALE_VERSION)_macOS_64-bit.tar.gz
VALE_WIN     := vale_$(VALE_VERSION)_Windows_64-bit.tar.gz
TOOLS_DIR    := $(LOCAL_DIR)/.tools
VALE         := $(TOOLS_DIR)/vale
VALE_OPTS    := --config=$(LOCAL_DIR)/_vale.ini
LINT         := $(LOCAL_DIR)/bin/lint

# Figure out the OS
ifeq ($(findstring ;,$(PATH)),;)
    # Windows, but not POSIX environment
else
    UNAME := $(shell uname 2>/dev/null || echo Unknown)
    UNAME := $(patsubst CYGWIN%,Windows,$(UNAME))
    UNAME := $(patsubst MSYS%,Windows,$(UNAME))
    UNAME := $(patsubst MINGW%,Windows,$(UNAME))
endif

# Find all RST source files in the current working directory (but skip the
# possible locations of third-party dependencies)
source_files := $(shell \
    find . -not -path '*/\.*' -name '*\.rst' -type f)

# Generate targets
lint_targets := $(patsubst %,%.lint,$(source_files))
delint_targets := $(patsubst %,%.delint,$(lint_targets))

# Default target
.PHONY: help
help:
	@ printf 'This Makefile is not supposed to be run manually.\n'
	@ exit 1;

$(ACTIVATE):
	$(PYTHON) -m venv $(ENV_DIR)
	. $(ACTIVATE) && \
	    $(PIP) install --upgrade pip
	. $(ACTIVATE) && \
	    $(PIP) install -r $(LOCAL_DIR)/requirements.txt

ifeq ($(UNAME),Linux)
$(VALE):
	mkdir -p $(TOOLS_DIR)
	curl -L $(VALE_URL)/$(VALE_LINUX) -o $(TOOLS_DIR)/$(VALE_LINUX)
	cd $(TOOLS_DIR) && tar -xzf $(VALE_LINUX)
endif

ifeq ($(UNAME),Darwin)
$(VALE):
	mkdir -p $(TOOLS_DIR)
	curl -L $(VALE_URL)/$(VALE_MACOS) -o $(TOOLS_DIR)/$(VALE_MACOS)
	cd $(TOOLS_DIR) && tar -xzf $(VALE_MACOS)
endif

.PHONY: vale
vale: $(ACTIVATE) $(VALE)
	@ if test ! -x $(VALE); then \
	    printf 'No rules to install Vale on your operating system.\n'; \
	    exit 1; \
	fi

.PHONY: tools
tools: vale

# Lint an RST file and dump the output
%.rst.lint: %.rst
	. $(ACTIVATE) && \
	    $(LINT) '$<' '$@'

.PHONY: lint
lint: tools $(lint_targets)

# Using targets for cleaning means we don't have to loop over the generated
# list of unescaped filenames
%.delint:
	@ # Fake the output so it's more readable
	@ filename=`echo $@ | sed s,.delint$$,,` && \
	    rm -f "$$filename" && \
	    printf "rm -f $$filename\n"

.PHONY: delint
delint: $(delint_targets)

.PHONY: reset
reset:
	rm -rf $(ENV_DIR)
	rm -rf $(TOOLS_DIR)
