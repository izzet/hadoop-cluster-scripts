#!/bin/bash

# Import utils
. ./utils/common.sh
. ./utils/hadoop.sh

# Check sudo privileges
utils-check-sudo

# Import credentials
eval "$(cat credentials.txt)"

# Setup Hadoop user
bash ./hadoop-user/setup.sh

# Setup Hadoop worker
bash ./hadoop-node-worker/setup.sh
