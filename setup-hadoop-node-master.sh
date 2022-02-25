#!/bin/bash

# Import utils
source ./utils/common.sh
source ./utils/hadoop.sh

# Check sudo privileges
utils-check-sudo

# Import vars
eval "$(cat credentials.txt)"

# Setup Hadoop user
bash ./hadoop-user/setup.sh

# Setup SSH keys
sudo -u $HADOOP_USER_NAME bash ./hadoop-user/setup-ssh-keys.sh

# Setup Hadoop worker
sudo -u $HADOOP_USER_NAME bash ./hadoop-node-worker/setup.sh
