#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

SERVERS=(4 8 12 16)
SCENARIOS=(large)

for server in ${SERVERS[@]}; do
    # Stop cluster
    echo "Stopping cluster..."
    $SCRIPTS_HOME/stop-cluster.sh &> /dev/null
    # Start cluster
    echo "Starting cluster with $server servers..."
    $SCRIPTS_HOME/start-cluster.sh $server &> /dev/null
    # Run scenarios
    for scenario in ${SCENARIOS[@]}; do
        echo "Running scenario: $server-$scenario"
        # Prepare benchmarks
        echo "Preparing benchmarks..."
        $SCRIPTS_HOME/prepare-benchmark-all.sh $server $scenario &> /dev/null
        # Run benchmarks
        echo "Running benchmarks..."
        for trial in {1..3}; do
            # Setup PAT
            echo "Setting up trial... ($server-$scenario-$trial)"
            $SCRIPTS_HOME/setup-pat-env.sh $server $scenario $trial &> /dev/null
            # Run trial
            echo "Running trial... ($server-$scenario-$trial)"
            pushd $PAT_HOME/collect
            ./pat run $server-$scenario-$trial !> /dev/null
            popd
        done
    done
done
