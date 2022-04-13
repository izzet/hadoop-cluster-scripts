#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ]; then
    echo "You must pass a cluster size and a data size!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: light, heavy"
    echo "Valid type: read, write"
    echo "For example: ./prepare-benchmark.sh 4 heavy read"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Create results file
mkdir -p $USER_MNT/hadoop/results
touch $USER_MNT/hadoop/results/$1-$2-$3-prep.txt

# Prepare file sizes
FILE_SIZE="128MB" && [[ $2 == "heavy" ]] && FILE_SIZE="640MB"

# Check if prepare is requested for read 
if [ $3 == "read" ]; then
    # Then start a write job to create the data
    $HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-client-jobclient-$HADOOP_VERSION-tests.jar \
        TestDFSIO \
        -Ddfs.blocksize=4m \
        -Dmapreduce.job.maps=8 \
        -Dmapreduce.job.reduces=8 \
        -Dtest.build.data=/benchmarks/$(hostname -s) \
        -write \
        -fileSize $FILE_SIZE \
        -nrFiles 40 \
        -resFile $USER_MNT/hadoop/results/$1-$2-$3-prep.txt
else
    # Otherwise just clear benchmark if possible
    $SCRIPTS_HOME/clear-benchmark.sh &> /dev/null
fi
