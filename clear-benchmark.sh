#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

# Clean the benchmark data
$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-$HADOOP_VERSION-tests.jar \
    TestDFSIO \
    -Dtest.build.data=/benchmarks/$(hostname -s)/ \
    -clean
