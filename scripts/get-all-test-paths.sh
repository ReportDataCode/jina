#!/usr/bin/env bash

set -ex

if [[ $1 == 'distributed' ]]; then
    declare -a array1=( "tests/distributed/*.py" )
    declare -a array2=( $(ls -d tests/distributed/*/ | grep -v '__pycache__' ))
    dest=( "${array1[@]}" "${array2[@]}" )

    printf '%s\n' "${dest[@]}" | jq -R . | jq -cs .
else
    declare -a array1=( "tests/unit/*.py" "tests/integration/*.py"  "tests/system/*.py")
    declare -a array2=( $(ls -d tests/{unit,integration,system}/*/ | grep -v '__pycache__' ))
    dest1=( "${array1[@]}" "${array2[@]}" )

    declare -a array1=( "tests/daemon/unit/*.py" )
    declare -a array2=( $(ls -d tests/daemon/{unit,integration}/*/ | grep -v '__pycache__' ))
    dest2=( "${array1[@]}" "${array2[@]}" )

    dest=( "${dest1[@]}" "${dest2[@]}" )

    printf '%s\n' "${dest[@]}" | jq -R . | jq -cs .
fi
