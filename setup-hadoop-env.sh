#!/bin/bash

eval "$(cat env)"

echo $JAVA_HOME
echo $HADOOP_HOME

cp core-site.xml $HADOOP_CORE_SITE
cp hdfs-site.xml $HADOOP_HDFS_SITE
cp mapred-site.xml $HADOOP_MAPRED_SITE
cp yarn-site.xml $HADOOP_YARN_SITE
cp workers $HADOOP_WORKERS_FILE

sed -i "s@#MASTER_NODE_NAME#@hdfs://$HADOOP_MASTER_NODE_NAME:9000@g" $HADOOP_CORE_SITE
sed -i "s@$HADOOP_ENV_HADOOP_HOME_0@$HADOOP_ENV_HADOOP_HOME_1@g" $HADOOP_ENV_FILE
sed -i "s@$HADOOP_ENV_JAVA_HOME_0@$HADOOP_ENV_JAVA_HOME_1@g" $HADOOP_ENV_FILE
sed -i "s@#DIR_DATANODE#@$HADOOP_DIR_DATANODE@g" $HADOOP_HDFS_SITE
sed -i "s@#DIR_NAMENODE#@$HADOOP_DIR_NAMENODE@g" $HADOOP_HDFS_SITE
sed -i "s@#MASTER_NODE_NAME#@$HADOOP_MASTER_NODE_NAME@g" $HADOOP_HDFS_SITE
sed -i "s@#MASTER_NODE#@$HADOOP_MASTER_NODE@g" $HADOOP_YARN_SITE

# if [ ! grep -q "${HADOOP_HOME}/bin" $HOME/.bashrc ]; then
    # echo "export HADOOP_HOME=$HADOOP_HOME" | sudo tee -a $HOME/.bashrc
    # echo "export PATH=${PATH}:${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin" | sudo tee -a $HOME/.bashrc
# fi

# pssh -i -h workers rm -rf /tmp/hadoop*
