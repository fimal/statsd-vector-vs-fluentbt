#!/bin/sh

docker ps -a  | grep Exited | awk '{print $1}' | xargs docker stop
docker ps -a  | grep Exited | awk '{print $1}' | xargs docker rm
docker image rm statsd-vector-vs-fluentbt-envoy:latest
