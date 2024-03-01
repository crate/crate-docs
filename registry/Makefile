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

LOCAL_DIR     := $(dir $(lastword $(MAKEFILE_LIST)))
PROJECTS_FILE := $(LOCAL_DIR)/github-projects.txt
CLONE_DIR     := $(LOCAL_DIR)/clones
URL_PREFIX    := https://github.com/crate
GIT_OPTS      :=--git-dir=.git
GIT           :=git $(GIT_OPTS)

projects := $(sort $(shell cat github-projects.txt))
clones := $(patsubst %,$(CLONE_DIR)/%,$(projects))

$(CLONE_DIR)/%:
	git clone $(URL_PREFIX)/$*.git $@
	-cd $@/docs; $(MAKE) qa

.PHONY: qa-data
qa-data: $(clones)

reset:
	rm -rf $(CLONE_DIR$)

csv:
	@find clones -path "*/.crate-docs/qa/*.csv"
