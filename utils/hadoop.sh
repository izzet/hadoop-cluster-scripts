#!/bin/bash

hadoop-download-binaries() {
    echo "⏳ Downloading Hadoop binaries..."
    local HADOOP_FOLDER=/home/$1
    local HADOOD_FILE=$HADOOP_FOLDER/hadoop-$2
    echo "- Downloading binaries into $HADOOP_FOLDER..."
    wget https://dlcdn.apache.org/hadoop/common/hadoop-$2/hadoop-$2.tar.gz -P $HADOOP_FOLDER
    echo "- Unzipping tar file..."
    tar -xzf $HADOOD_FILE.tar.gz -C $HADOOP_FOLDER
    echo "- Moving directory..."
    mv $HADOOD_FILE $HADOOP_FOLDER/hadoop
    echo "- Removing tar file..."
    rm $HADOOD_FILE.tar.gz
    echo "- Changing ownership of binaries..."
    chown -R $1:$1 $HADOOP_FOLDER
    echo "✅ Hadoop binaries downloaded"
}

hadoop-install-dependencies() {
    echo "- Installing Hadoop dependencies..."
    sudo yum install -y -q java-1.8.0-openjdk
}

"${@}"