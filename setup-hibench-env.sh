#!/bin/bash

eval "$(cat env)"

pssh -h clients rm -rf $HIBENCH_HOME/
pssh -h clients mkdir -p $HIBENCH_HOME/
pssh -h clients cp -R $HIBENCH_TMP/* $HIBENCH_HOME/
