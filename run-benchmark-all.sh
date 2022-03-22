#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./run-benchmark.sh 4 large"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

pssh -t 0 -h $(dirname "$0")/clients $SCRIPTS_HOME/run-benchmark.sh $1 $2
