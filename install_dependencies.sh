#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

wget --no-check-certificate https://dlcdn.apache.org/hadoop/common/hadoop-$HADOOP_VERSION/hadoop-$HADOOP_VERSION.tar.gz -P $USER_HOME
tar -xzf $USER_HOME/hadoop-$HADOOP_VERSION.tar.gz -C $USER_HOME
rm $USER_HOME/hadoop-$HADOOP_VERSION.tar.gz

wget --no-check-certificate https://github.com/Intel-bigdata/HiBench/archive/refs/tags/v$HIBENCH_VERSION.tar.gz -P $USER_HOME
tar -xzf $USER_HOME/v$HIBENCH_VERSION.tar.gz -C $USER_HOME
mv $USER_HOME/HiBench-$HIBENCH_VERSION $USER_HOME/hibench-$HIBENCH_VERSION
rm $USER_HOME/v$HIBENCH_VERSION.tar.gz
pushd $USER_HOME/hibench-$HIBENCH_VERSION
sed -i "s|<repo2>http://archive.cloudera.com</repo2>|<repo2>https://archive.apache.org</repo2>|" hadoopbench/mahout/pom.xml
sed -i "s|cdh5/cdh/5/mahout-0.9-cdh5.1.0.tar.gz|dist/mahout/0.9/mahout-distribution-0.9.tar.gz|" hadoopbench/mahout/pom.xml
sed -i "s|aa953e0353ac104a22d314d15c88d78f|09b999fbee70c9853789ffbd8f28b8a3|" hadoopbench/mahout/pom.xml
mvn -Phadoopbench clean package
popd
