#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./prepare-benchmark.sh 4 large"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Clear input outputs
$HADOOP_HOME/bin/hdfs dfs -rm -r "/HiBench/*" &> /dev/null

# Prepare benchmarks
mpssh -t 0 -f $(dirname "$0")/clients "$SCRIPTS_HOME/prepare-benchmark.sh $1 $2"
