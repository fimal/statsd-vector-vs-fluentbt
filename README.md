# statsd-vector-vs-fluentbt

- This repo created to simulate functionality and compare statsd in fluentbit vs vector

## Getting Started
- Create sandbox with docker-compose
- Test runs 60 seconds and stops, all results will be redirected to results.log
- in case required to change duration of this test, please change [start_k6.sh](#k6/start_k6.sh) - {DURATION} variable 

## Fluent-BIT tests
- Start test with fluentbit
```bash
docker-compose -f docker-compose-fluentbit.yaml up -d && ./monitor.sh fluentbit results.log
# stop all containers after test finishes
docker-compose -f docker-compose-fluentbit.yaml down && ./init.sh
```

- Start test with vector
## Vector test
```bash
docker-compose -f docker-compose-vector.yaml up -d && ./monitor.sh vector results.log
# stop all containers after test finishes
docker-compose -f docker-compose-vector.yaml down && ./init.sh
```

## Monitoring containers with cadvisor
- cadvisor expose port 8080 to access GUI

```bash
docker run --volume=/:/rootfs:ro --volume=/var/run:/var/run:ro --volume=/sys:/sys:ro --volume=/var/lib/docker/:/var/lib/docker:ro --publish=8080:8080 --detach=true --name=cadvisor gcr.io/cadvisor/cadvisor:latest
```