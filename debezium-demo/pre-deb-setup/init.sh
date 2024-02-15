#!/bin/bash

set -e
sleep 20
mysql -hfakeservices.datajoint.io -uroot -ppassword -e 'SHOW DATABASES;' | grep 'djtest_university'
declare -a endpoints=("my_stream" "schema_changes" "schema_changes.djtest_university.department")
for endpoint in "${endpoints[@]}"; do
	curl -sf -u 'guest:guest' \
	     -H 'content-type:application/json' \
		 -XPUT -d'{"type":"topic","durable":true}' \
		 "http://rabbitmq:15672/api/exchanges/%2f/${endpoint}"
done
echo 'Finished pre Debezium setup'
exit 0
