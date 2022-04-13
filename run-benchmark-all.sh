#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ] || [ ! -n "$4" ]; then
    echo "You must pass a cluster size, a data size and a trial number!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: light, heavy"
    echo "Valid type: read, write"
    echo "Valid trial: 1, 2, 3"
    echo "For example: ./run-benchmark-all.sh 4 heavy read 1"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Run benchmarks
mpssh -t 0 -f $(dirname "$0")/clients "$SCRIPTS_HOME/run-benchmark.sh $1 $2 $3 $4"

# Show benchmark results
mpssh -t 0 -f $(dirname "$0")/clients "cat $USER_MNT/hadoop/results/$1-$2-$3-$4.txt"
