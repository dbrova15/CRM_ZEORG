#!/usr/bin/env bash

declare -a FAILURES

add_fail() {
    FAILURES+=("$1")
}

black --check . || add_fail black
#pylint CRM_ZEORG || add_fail pylint
flake8 CRM_ZEORG || add_fail flake8
#pydocstyle CRM_ZEORG || add_fail pydocstyle
mypy CRM_ZEORG || add_fail mypy
py.test -v tests || add_fail py.test
if [[ ${#FAILURES[@]} -ne 0 ]]; then
    cat <<RESULT

===================================================
= Code assessment is failed! Please fix errors!!! =
===================================================
Failed tool(s):
RESULT
    for var in "${FAILURES[@]}"; do
        echo "- ${var}"
    done
    exit 11
fi
