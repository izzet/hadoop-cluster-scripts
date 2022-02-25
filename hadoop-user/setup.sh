#!/bin/bash

echo "⏳ Adding hadoop user..."

# Import vars
eval $(cat $(dirname "$0")/../credentials.txt)

if [[ -z "${HADOOP_USER_NAME}" ]]; then
    echo "❌ Credentials not found"
    exit
fi

# Create user
adduser -m -p $(openssl passwd -1 $HADOOP_USER_PWD) -s /bin/bash -G wheel $HADOOP_USER_NAME

echo "✅ hadoop user added"