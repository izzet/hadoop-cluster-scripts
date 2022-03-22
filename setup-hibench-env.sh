#!/bin/bash

eval "$(cat env)"

# hibench.report.dir    /tmp/hibench/logs
cp -R $HIBENCH_HOME/conf/ $HIBENCH_CONF_DIR/
