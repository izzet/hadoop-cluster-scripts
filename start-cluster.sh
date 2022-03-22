#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a cluster size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    exit 1
fi

eval "$(cat env)"

# Arrange workers
echo -n "" > workers
for i in $(seq 1 $1); do
    echo "symbios-server-$i" >> workers; 
done

# Start Hadoop cluster
cp workers $HADOOP_WORKERS_FILE
$HADOOP_HOME/sbin/start-all.sh

# Setup PAT
WORKERS=$(cat workers | awk '{ printf("%s ", $0) }')
cp pat.conf $PAT_CONF_FILE
sed -i "s@#WORKERS#@$WORKERS@g" $PAT_CONF_FILE

# hdfs namenode -format
