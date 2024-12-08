#!/bin/sh

# Resolve IP (envoy udp statsd sink use only ip address as it is not a cluster)
LOG_PROCESSOR_IP=$(getent hosts ${LOG_PROCESSOR} | awk '{ print $1 }'| head -n1)

if [ -z "$LOG_PROCESSOR_IP" ]; then
    echo "Hostname '${LOG_PROCESSOR}' could not be resolved to an IP address."
else
    echo "The IP address of ${LOG_PROCESSOR} is ${LOG_PROCESSOR_IP}"
fi
export LOG_PROCESSOR_IP
sed -e "s/\${SERVICE_NAME}/${SERVICE_NAME}/" -e "s/\${SERVICE_PORT}/${SERVICE_PORT}/" -e "s/\${LOG_PROCESSOR_IP}/${LOG_PROCESSOR_IP}/" \
    /config/envoy.yaml > /etc/envoy.yaml

/usr/local/bin/envoy -c /etc/envoy.yaml -l ${DEBUG_LEVEL}
