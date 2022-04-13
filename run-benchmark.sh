#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ] || [ ! -n "$4" ]; then
    echo "You must pass a cluster size, a data size and a trial number!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: light, heavy"
    echo "Valid type: read, write"
    echo "Valid trial: 1, 2, 3"
    echo "For example: ./run-benchmark.sh 4 heavy read 1"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Create results file
mkdir -p $USER_MNT/hadoop/results
touch $USER_MNT/hadoop/results/$1-$2-$3-$4.txt

# Prepare file sizes
FILE_SIZE="128MB" && [[ $2 == "heavy" ]] && FILE_SIZE="640MB"

# Run DFSIO benchmark
$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-$HADOOP_VERSION-tests.jar \
    TestDFSIO \
    -Ddfs.blocksize=4m \
    -Dmapreduce.job.maps=8 \
    -Dmapreduce.job.reduces=8 \
    -Dtest.build.data=/benchmarks/$(hostname -s) \
    -$3 \
    -fileSize $FILE_SIZE \
    -nrFiles 40 \
    -resFile $USER_MNT/hadoop/results/$1-$2-$3-$4.txt
