#!/bin/bash

if [ ! -n "$1" ] || [ ! -n "$2" ] || [ ! -n "$3" ] || [ ! -n "$4" ]; then
    echo "You must pass a cluster size, a data size and a trial number!"
    echo "Valid cluster sizes: 4, 8, 12, 16, 20, 24"
    echo "Valid data sizes: light, heavy"
    echo "Valid type: read, write"
    echo "Valid trial: 1, 2, 3"
    echo "For example: ./setup-pat-env.sh 4 heavy read 1"
    exit 1
fi

eval "$(cat $(dirname "$0")/env)"

# Setup PAT
WORKERS=$(cat workers | awk '{ printf("%s ", $0) }')
cp pat.conf $PAT_CONF_FILE
sed -i "s@#ALL_NODES#@$WORKERS@g" $PAT_CONF_FILE
sed -i "s@#WORKER_SCRIPT_DIR#@$PAT_WORKER_SCRIPTS_DIR@g" $PAT_CONF_FILE
sed -i "s@#WORKER_TMP_DIR#@$PAT_WORKER_DATA_DIR@g" $PAT_CONF_FILE
sed -i "s@#CMD_PATH#@$SCRIPTS_HOME/run-benchmark-all.sh $1 $2 $3 $4@g" $PAT_CONF_FILE
