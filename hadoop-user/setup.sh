#!/bin/bash

# Import utils
. ./_utils.sh

# Check sudo privileges
utils-check-sudo

# Import credentials
eval "$(cat credentials.txt)"

# Create Hadoop group
addgroup hadoop

# Create user
useradd -m -p $(openssl passwd -1 $HADOOP_USER_PWD) -s /bin/bash -g hadoop $HADOOP_USER_NAME

# Add user to sudo
adduser $HADOOP_USER_NAME sudo
