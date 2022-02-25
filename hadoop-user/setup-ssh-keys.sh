#!/bin/bash

# Import vars
eval $(cat $(dirname "$0")/../credentials.txt)
eval $(cat $(dirname "$0")/../nodes.txt)

echo "⏳ Setting up SSH keys..."

# Install dependencies
echo "- Installing dependencies..."
sudo yum install -y -q wget sshpass

# Setting up SSH keys
echo "- Generating the SSH key..."
ssh-keygen -q -f $HOME/.ssh/id_rsa -t rsa -N "" <<< y
printf "\n"

echo "- Copying key to worker nodes..."
for WORKER_NODE in $HADOOP_WORKER_NODES; do
    sshpass -f $HADOOP_USER_PWD ssh-copy-id $HADOOP_USER_NAME@$WORKER_NODE
done