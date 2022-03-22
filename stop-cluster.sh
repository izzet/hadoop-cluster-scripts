#!/bin/bash

eval "$(cat env)"

$HADOOP_HOME/sbin/stop-all.sh

pssh -i -h workers rm -rf /tmp/hadoop*
