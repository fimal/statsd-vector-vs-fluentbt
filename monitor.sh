#!/bin/bash
cd "$(dirname "$0")"


monitor() {
    while [[ ($(docker inspect -f {{.State.Running}} $LOGAGENT) == true) && ($(docker inspect -f {{.State.Running}} k6) == true) ]]; do
        echo "$(date '+%Y-%m-%d %H:%M:%S'), $(docker stats --no-stream --format "{{.Container}}, {{.CPUPerc}}" $LOGAGENT)" | tee >> "$FILE"
        sleep 2
    done
}
usage() {
    echo "Usage: $0 {fluentbit}|{vecor} {log_file}" 1>&2
    exit 1
}
if (($# != 2));then
    usage
else
    LOGAGENT=$1
    shift
    FILE=$1
    shift
    monitor
fi