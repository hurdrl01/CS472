#! /bin/bash

if ! [[ -x pzip ]]; then
    echo "pzip executable does not exist"
    exit 1
fi

time ./run-tests.sh $*

