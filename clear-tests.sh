#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

rm -rf $PAT_LOG_DIR
mkdir -p $PAT_LOG_DIR

mpssh -t 0 -f $(dirname "$0")/clients "rm -rf $HIBENCH_LOG_DIR"
mpssh -t 0 -f $(dirname "$0")/clients "mkdir -p $HIBENCH_LOG_DIR"
