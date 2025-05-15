#!/usr/bin/env bash
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

