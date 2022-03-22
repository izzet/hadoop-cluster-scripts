#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a data size!"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./prepare-benchmark.sh large"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

sed -i "s@hibench.scale.profile@#hibench.scale.profile@g" $HIBENCH_CONF_FILE
echo "hibench.scale.profile     $1" >> $HIBENCH_CONF_FILE

sed -i "s@hibench.workload.input@#hibench.workload.input@g" $HIBENCH_TERASORT_CONF_FILE
sed -i "s@hibench.workload.output@#hibench.workload.output@g" $HIBENCH_TERASORT_CONF_FILE
echo "hibench.workload.input    \${hibench.hdfs.data.dir}/Terasort/Input/$(hostname -s)" >> $HIBENCH_TERASORT_CONF_FILE
echo "hibench.workload.output    \${hibench.hdfs.data.dir}/Terasort/Output/$(hostname -s)" >> $HIBENCH_TERASORT_CONF_FILE

$HIBENCH_HOME/bin/workloads/micro/terasort/prepare/prepare.sh
