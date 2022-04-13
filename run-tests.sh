#!/bin/bash

eval "$(cat $(dirname "$0")/env)"

SERVERS=(4 8 12 16 20 24)
SCENARIOS=(light heavy)
TYPES=(read write)

for server in ${SERVERS[@]}; do
    # Stop cluster
    echo "Stopping cluster..."
    $SCRIPTS_HOME/stop-cluster.sh &> /dev/null
    # Start cluster
    echo "Starting cluster with $server servers..."
    $SCRIPTS_HOME/start-cluster.sh $server &> /dev/null   
    # Run scenarios
    for scenario in ${SCENARIOS[@]}; do
        # Loop through types
        for type in ${TYPES[@]}; do
            echo "Running scenario: $server-$scenario-$type"
            # Prepare benchmarks
            echo "Preparing benchmarks..."
            $SCRIPTS_HOME/prepare-benchmark-all.sh $server $scenario $type &> /dev/null
            # Run benchmarks
            echo "Running benchmarks..."
            for trial in {1..2}; do
                # Setup PAT
                echo "Setting up trial... ($server-$scenario-$type-$trial)"
                $SCRIPTS_HOME/setup-pat-env.sh $server $scenario $type $trial &> /dev/null
                # Run trial
                echo "Running trial... ($server-$scenario-$type-$trial)"
                pushd $PAT_HOME/collect
                ./pat run $server-$scenario-$type-$trial &> /dev/null
                popd
            done
            # Clear benchmarks
            echo "Clearing benchmark artifacts..."
            $SCRIPTS_HOME/clear-benchmark-all.sh &> /dev/null
        done
    done
done
