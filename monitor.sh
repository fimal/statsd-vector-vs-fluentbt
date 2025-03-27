#!/bin/bash
# kubectl top nodes --no-headers | awk '{print "{\"name\": \"" $1 "\", \"cpu\": \"" $2 "\", \"memory\": \"" $3 "\"}"}' | jq -s
# kubectl top pods --no-headers --all-namespaces | awk '{print "{\"namespace\": \"" $1 "\", \"name\": \"" $2 "\", \"cpu\": \"" $3 "\", \"memory\": \"" $4 "\"}"}' | jq -s
cd "$(dirname "$0")"


monitor() {
    while [[ ($(docker inspect -f {{.State.Running}} $LOGAGENT) == true) && ($(docker inspect -f {{.State.Running}} k6) == true) ]]; do
        sleep 2
        echo "$(date '+%Y-%m-%d %H:%M:%S'), $(docker stats --no-stream --format "{{.Container}}, {{.CPUPerc}}" $LOGAGENT)" 2>&1 | tee -a "$FILE"
        sleep 2
    done
}
usage() {
    echo "Usage: $0 {fluentbit}|{vecor} {log_file}" 1>&2
    exit 1
}
if (($# != 1));then
    usage
else
    LOGAGENT=$1
    FILE=results_${LOGAGENT}_$(date +"%H-%M-%S").log
    monitor
fi
