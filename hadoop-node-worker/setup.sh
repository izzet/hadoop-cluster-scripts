#!/bin/bash

# Vars
HADOOP_VERSION=3.2.2

# Import utils
source $(dirname "$0")/../utils/common.sh
source $(dirname "$0")/../utils/hadoop.sh

# Import vars
eval $(cat $(dirname "$0")/../credentials.txt)
eval $(cat $(dirname "$0")/../nodes.txt)

echo "⏳ Setting up Hadoop worker..."

# Install dependencies
hadoop-install-dependencies

# Download Hadoop binaries
# hadoop-download-binaries $HADOOP_USER_NAME $HADOOP_VERSION

echo "- Setting JAVA_HOME env..."
# Prepare variables
JAVA_BIN=/bin/java
JAVA_LINK=$(readlink -f $(which java))
JAVA_HOME=${JAVA_LINK/$JAVA_BIN/""}
echo $JAVA_HOME
# Set variables
if ! grep -q "JAVA_HOME" /etc/environment; then
    echo "JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/environment
fi

echo "- Setting Hadoop env..."
# Prepare variables
HADOOP_HOME=$HOME/hadoop
HADOOP_CORE_SITE=$HADOOP_HOME/etc/hadoop/core-site.xml
HADOOP_ENV_FILE=$HADOOP_HOME/etc/hadoop/hadoop-env.sh
HADOOP_ENV_JAVA_HOME="export JAVA_HOME"
HADOOP_ENV_JAVA_HOME_0="# $HADOOP_ENV_JAVA_HOME="
HADOOP_ENV_JAVA_HOME_1="$HADOOP_ENV_JAVA_HOME=$JAVA_HOME"
HADOOP_HDFS_SITE=$HADOOP_HOME/etc/hadoop/hdfs-site.xml
HADOOP_MAPRED_SITE=$HADOOP_HOME/etc/hadoop/mapred-site.xml
HADOOP_WORKERS=$HADOOP_HOME/etc/hadoop/workers
HADOOP_YARN_SITE=$HADOOP_HOME/etc/hadoop/yarn-site.xml
echo $HADOOP_HOME
echo "$HADOOP_MASTER_NODE_NAME:$HADOOP_MASTER_NODE"
echo "$HADOOP_WORKER_NODE_NAMES:$HADOOP_WORKER_NODES"
# Set variables
cp $(dirname "$0")/core-site.xml $HADOOP_CORE_SITE
cp $(dirname "$0")/hdfs-site.xml $HADOOP_HDFS_SITE
cp $(dirname "$0")/mapred-site.xml $HADOOP_MAPRED_SITE
cp $(dirname "$0")/yarn-site.xml $HADOOP_YARN_SITE
sed -i "s@$HADOOP_ENV_JAVA_HOME_0@$HADOOP_ENV_JAVA_HOME_1@g" $HADOOP_ENV_FILE
sed -i "s@#MASTER_NODE_NAME#@hdfs://$HADOOP_MASTER_NODE_NAME:9000@g" $HADOOP_CORE_SITE
sed -i "s@#MASTER_NODE#@$HADOOP_MASTER_NODE@g" $HADOOP_YARN_SITE
if ! grep -q "${HADOOP_HOME}/bin" $HOME/.bashrc; then
    echo "export HADOOP_HOME=$HOME/hadoop" | sudo tee -a $HOME/.bashrc
    echo "export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin" | sudo tee -a $HOME/.bashrc
fi
