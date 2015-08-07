#!/usr/bin/env bash

set -e -u -o pipefail

rm -f core.* starting-to-block
if output=$(./dump_core_on_job_delay_test.exe 2>&1); then
    rm -f starting-to-block
    echo "$output"
    echo >&2 "
Failure: $0
  The program did not appear to be aborted."
    exit 1
else    
    rm -f core.*
    if ! [ -e starting-to-block ]; then
        echo "$output"
        echo >&2 "\
Failure: $0
  The program was aborted too soon."
        exit 1
    fi
    rm -f starting-to-block
    echo "Success: $0"
fi

