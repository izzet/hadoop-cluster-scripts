#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a data size!"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./prepare-benchmark.sh large"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

pssh -t 0 -h clients $SCRIPTS_HOME/prepare-benchmark.sh $1
