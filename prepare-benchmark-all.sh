#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: light, heavy"
    echo "Valid type: read, write"
    echo "For example: ./prepare-benchmark-all.sh 4 heavy read"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Prepare benchmarks
mpssh -t 0 -f $(dirname "$0")/clients "$SCRIPTS_HOME/prepare-benchmark.sh $1 $2 $3"

# Show prepared input data
$HADOOP_HOME/bin/hdfs dfs -du -h /benchmarks/
