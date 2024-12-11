# statsd-vector-vs-fluentbt
comparing statsd in vector vs fluentbit


# Test runs 30 seconds and finish, all reasults will be sent to results.log
## in case required to change duration of the test, please change k6/start_k6.sh script <DURATION> variable

## Fluent-BIT tests
```bash
docker-compose -f docker-compose-fluentbit.yaml up -d && ./monitor.sh fluentbit results.log
docker-compose -f docker-compose-fluentbit.yaml down && ./init.sh
```

## Vector test
```bash
docker-compose -f docker-compose-vector.yaml up -d && ./monitor.sh vector results.log
docker-compose -f docker-compose-vector.yaml down && ./init.sh
```

