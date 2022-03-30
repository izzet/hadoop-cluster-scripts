#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "For example: ./start-cluster.sh 4"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Arrange workers
cp workers-$1 workers
cp workers-$1 $HADOOP_WORKERS_FILE

# Clear datanodes
mpssh -f workers "rm -rf $HADOOP_DIR_DATANODE"

# Start Hadoop cluster
$HADOOP_HOME/sbin/start-all.sh

# Show status
$HADOOP_HOME/bin/hdfs dfsadmin -safemode leave
$HADOOP_HOME/bin/hdfs dfsadmin -report
