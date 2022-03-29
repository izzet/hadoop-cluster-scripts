#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

HIBENCH_HADOOP_CONF=$HIBENCH_TMP/conf/hadoop.conf
cp hibench.hadoop.conf $HIBENCH_HADOOP_CONF
sed -i "s@#HADOOP_HOME#@$HADOOP_HOME@g" $HIBENCH_HADOOP_CONF
sed -i "s@#HADOOP_MASTER_NODE_NAME#@$HADOOP_MASTER_NODE_NAME@g" $HIBENCH_HADOOP_CONF

sleep 5

mpssh -f clients "rm -rf $HIBENCH_HOME/"
mpssh -f clients "mkdir -p $HIBENCH_HOME/"
mpssh -f clients "cp -R $HIBENCH_TMP/* $HIBENCH_HOME/"
