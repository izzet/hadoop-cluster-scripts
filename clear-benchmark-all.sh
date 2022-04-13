#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

# Clear benchmarks
mpssh -t 0 -f $(dirname "$0")/clients "$SCRIPTS_HOME/clear-benchmark.sh"
