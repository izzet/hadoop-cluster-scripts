#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: small, large, huge"
    echo "For example: ./start-cluster.sh 4 large"
    exit 1
fi

eval "$(cat env)"

# Format NameNode
# $HADOOP_HOME/bin/hdfs namenode -format

# Start Hadoop cluster
cp workers-$1 workers
cp workers-$1 $HADOOP_WORKERS_FILE
$HADOOP_HOME/sbin/start-all.sh

# Setup PAT
WORKERS=$(cat workers | awk '{ printf("%s ", $0) }')
cp pat.conf $PAT_CONF_FILE
sed -i "s@#ALL_NODES#@$WORKERS@g" $PAT_CONF_FILE
sed -i "s@#WORKER_SCRIPT_DIR#@$PAT_WORKER_SCRIPTS_DIR@g" $PAT_CONF_FILE
sed -i "s@#WORKER_TMP_DIR#@$PAT_WORKER_DATA_DIR@g" $PAT_CONF_FILE
sed -i "s@#CMD_PATH#@$SCRIPTS_HOME/run-benchmark-all.sh $1 $2@g" $PAT_CONF_FILE

# Show status
$HADOOP_HOME/bin/hdfs dfsadmin -report
