#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

wget --no-check-certificate https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P $USER_HOME
tar -xzf $USER_HOME/hadoop-$HADOOP_VERSION.tar.gz -C $USER_HOME
rm $USER_HOME/hadoop-$HADOOP_VERSION.tar.gz
