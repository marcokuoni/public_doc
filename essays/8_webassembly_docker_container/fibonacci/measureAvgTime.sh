#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 <command> <num_runs>"
    exit 1
fi

command_to_measure="$1"
num_runs=$2

total_execution_time=0
total_startup_time=0
total_runtime_time=0
total_shutdown_time=0

for ((i=1; i<=$num_runs; i++)); do
    start_time=$(date +%s.%N)
    started_time=$(date +%s.%N)
    stopped_time=$(date +%s.%N)

    $command_to_measure  | while IFS= read -r line; do 
            case "$line" in
                "Starting")
                    started_time=$(date +%s.%N)                
                ;;
                "Stopped")
                    stopped_time=$(date +%s.%N)                
                ;;
                *)
                # echo "$line"
                ;;
            esac
        done
    end_time=$(date +%s.%N)

    execution_time=$(echo "$end_time - $start_time" | bc -l)
    startup_time=$(echo "$started_time - $start_time" | bc -l)
    runtime_time=$(echo "$stopped_time - $started_time" | bc -l)
    shutdown_time=$(echo "$end_time - $stopped_time" | bc -l)
    total_execution_time=$(echo "$total_execution_time + $execution_time" | bc -l)
    total_startup_time=$(echo "$total_startup_time + $startup_time" | bc -l)
    total_runtime_time=$(echo "$total_runtime_time + $runtime_time" | bc -l)
    total_shutdown_time=$(echo "$total_shutdown_time + $shutdown_time" | bc -l)
done

avg_total_execution_time=$(echo "$total_execution_time / $num_runs" | bc -l)
avg_total_startup_time=$(echo "$total_startup_time / $num_runs" | bc -l)
avg_total_runtime_time=$(echo "$total_runtime_time / $num_runs" | bc -l)
avg_total_shutdown_time=$(echo "$total_shutdown_time / $num_runs" | bc -l)
echo "Average execution time over $num_runs runs: $avg_total_execution_time seconds"
echo "Average startup time over $num_runs runs: $avg_total_startup_time seconds"
echo "Average run time over $num_runs runs: $avg_total_runtime_time seconds"
echo "Average shutdown time over $num_runs runs: $avg_total_shutdown_time seconds"
