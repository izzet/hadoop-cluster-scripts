#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ]; then
    echo "You must pass a cluster size, a data size and a trial number!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "Valid trial: 1, 2, 3"
    echo "For example: ./run-benchmark.sh 4 large 1"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

$HIBENCH_HOME/bin/workloads/micro/terasort/hadoop/run.sh

CURRENT_LOG_DIR=/tmp/hadoop/results/$1-$2-$3/hibench

rm -rf $CURRENT_LOG_DIR
mkdir -p $CURRENT_LOG_DIR

cp -R $HIBENCH_LOG_DIR/* $CURRENT_LOG_DIR/
