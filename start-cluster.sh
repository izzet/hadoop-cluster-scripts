#!/bin/bash

if [ ! -n "$1" ]; then
    echo "You must pass a cluster size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    exit 1
fi

eval "$(cat env)"

echo -n "" > workers
for i in $(seq 1 $1); do
    echo "symbios-server-$i" >> workers; 
done

cp workers $HADOOP_WORKERS

$HADOOP_HOME/sbin/start-all.sh
