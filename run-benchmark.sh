#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./run-benchmark.sh 4 large"
    exit 1
fi

eval "$(cat env)"

$HIBENCH_HOME/bin/workloads/micro/terasort/hadoop/run.sh

CURRENT_LOGS_DIR=$SCRIPTS_HOME/logs/$1-$2

rm -rf $CURRENT_LOGS_DIR
mkdir -p $CURRENT_LOGS_DIR

cp -R $HIBENCH_LOG_DIR/ $CURRENT_LOGS_DIR/
