#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a data size!"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./prepare-benchmark.sh large"
    exit 1
fi

eval "$(cat env)"

sed -i "s@hibench.scale.profile@#hibench.scale.profile@g" $HIBENCH_CONF_FILE
echo "hibench.scale.profile     $1" >> $HIBENCH_CONF_FILE

$HIBENCH_HOME/bin/workloads/micro/terasort/prepare/prepare.sh
