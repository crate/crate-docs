#!/bin/sh -e

# Licensed to Crate (https://crate.io) under one or more contributor
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

# Check if everything is committed
CLEAN=`git status -s`
if test ! -z "$CLEAN"; then
   echo "Working directory not clean. Commit all changes before tagging."
   echo "Aborting."
   exit 1
fi

echo "Fetching origin..."
git fetch origin > /dev/null

REGEXP='^\d+\.\d+\.\d+ - \d{4}/\d{2}/\d{2}$'
VERSION=`grep -E "$REGEXP" CHANGES.rst | head -n 1 | awk '{print $1}'`
echo "Found version $VERSION."

# Check if tag to create has already been created
if test "$VERSION" = "`git tag | grep $VERSION`"; then
   echo "Version $VERSION already tagged. Aborting."
   exit 1
fi

echo "Creating tag $VERSION..."
git tag -a "$VERSION" -m "Tag version $VERSION"
git push --tags
echo "Done."
