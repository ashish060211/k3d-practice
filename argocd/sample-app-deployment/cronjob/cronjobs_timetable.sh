#!/bin/bash
# script name: cronjobs_timetable.sh <NAMESPACE>
namespace=$1

for cronjob_name in $(kubectl get cronjobs -n $namespace --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'); do
    echo "===== CRONJOB_NAME: ${cronjob_name} ==========="

    printf "%-15s %-15s %-15s %-15s\n" "START_TIME" "COMPLETION_TIME" "DURATION" "JOB_NAME"
    for job_name in $(kubectl get jobs -n $namespace --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' | grep -w "${cronjob_name}-[0-9]*$"); do

        startTime="$(kubectl get job ${job_name} -n $namespace --template '{{.status.startTime}}')"
        completionTime="$(kubectl get job ${job_name} -n $namespace --template '{{.status.completionTime}}')"
        if [[ "$completionTime"  == "<no value>" ]]; then
            continue
        fi
        duration=$[ $(date -d "$completionTime" +%s) - $(date -d "$startTime" +%s) ]
        printf "%-15s %-15s %-15s %-15s\n" "$(date -d ${startTime} +%X)" "$(date -d ${completionTime} +%X)" "${duration} s" "$job_name"
    done
done