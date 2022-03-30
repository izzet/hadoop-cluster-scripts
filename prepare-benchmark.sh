#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./prepare-benchmark.sh 4 large"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

sed -i "s@hibench.default.map.parallelism@#hibench.default.map.parallelism@g" $HIBENCH_CONF_FILE
sed -i "s@hibench.default.shuffle.parallelism@#hibench.default.shuffle.parallelism@g" $HIBENCH_CONF_FILE
sed -i "s@hibench.scale.profile@#hibench.scale.profile@g" $HIBENCH_CONF_FILE
echo "hibench.default.map.parallelism     8" >> $HIBENCH_CONF_FILE
echo "hibench.default.shuffle.parallelism     8" >> $HIBENCH_CONF_FILE
echo "hibench.scale.profile     $2" >> $HIBENCH_CONF_FILE

sed -i "s@hibench.terasort.huge.datasize@#hibench.terasort.huge.datasize@g" $HIBENCH_TERASORT_CONF_FILE
sed -i "s@hibench.workload.datasize@#hibench.workload.datasize@g" $HIBENCH_TERASORT_CONF_FILE
sed -i "s@hibench.workload.input@#hibench.workload.input@g" $HIBENCH_TERASORT_CONF_FILE
sed -i "s@hibench.workload.output@#hibench.workload.output@g" $HIBENCH_TERASORT_CONF_FILE
echo "hibench.terasort.huge.datasize    80000000" >> $HIBENCH_TERASORT_CONF_FILE
echo "hibench.workload.datasize    \${hibench.terasort.\${hibench.scale.profile}.datasize}" >> $HIBENCH_TERASORT_CONF_FILE
echo "hibench.workload.input    \${hibench.hdfs.data.dir}/Terasort/Input/$(hostname -s)" >> $HIBENCH_TERASORT_CONF_FILE
echo "hibench.workload.output    \${hibench.hdfs.data.dir}/Terasort/Output/$(hostname -s)" >> $HIBENCH_TERASORT_CONF_FILE

$HIBENCH_HOME/bin/workloads/micro/terasort/prepare/prepare.sh
