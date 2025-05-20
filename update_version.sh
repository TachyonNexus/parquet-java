#!/usr/bin/env bash
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
set -e # exit if a command fails
set -u # unbound variable is an error

HELP=$(cat <<EOF
Usage: update-version.sh [-s] <docs path> <old version> <new version>

    <path>      The path of the folder that need update (i.e. ./parquet-arrow or .)
    <old version>    The version to replace throughout the
                     (i.e. 1.15.1-Alluxio)
    <new version>    The new version in the codebase (i.e. 2.2.0-RC1)

EOF
)

function update_string() {
    find "${1}" -name 'pom.xml' | xargs -t -n 1 perl -pi -e "s/\Q${2}\E/${3}/g"
}


function main() {
    if [[ "$#" -lt 3 ]]; then
        echo "Arguments '<path>', '<old version>' and '<new version>' must be provided."
        echo "${HELP}"
        exit 1
    fi
    local _path="${1}"
    local _old="${2}"
    local _new="${3}"

    update_string "$_path" "$_old" "$_new"

    exit 0
}

main "$@"

