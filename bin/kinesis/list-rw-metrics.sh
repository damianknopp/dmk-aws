#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

now=$($date_cmd --iso-8601=minutes)
day_ago=$($date_cmd --iso-8601=minutes -d '-1 day')

full_day_secs=86400

echo "Count records written to ${stream_name}"
aws --profile ${profile} cloudwatch get-metric-statistics \
--metric-name PutRecords.Records \
--start-time ${day_ago} \
--end-time ${now} \
--period ${full_day_secs} \
--statistics Sum \
--namespace AWS/Kinesis \
--dimensions Name=StreamName,Value=${stream_name} | jq .

echo "Sum bytes written to ${stream_name}"
aws --profile ${profile} cloudwatch get-metric-statistics \
--metric-name PutRecords.Bytes \
--start-time ${day_ago} \
--end-time ${now} \
--period ${full_day_secs} \
--statistics Sum \
--namespace AWS/Kinesis \
--unit Bytes \
--dimensions Name=StreamName,Value=${stream_name} | jq .

echo "Count records read from ${stream_name}"
aws --profile ${profile} cloudwatch get-metric-statistics \
--metric-name GetRecords.Records \
--start-time ${day_ago} \
--end-time ${now} \
--period ${full_day_secs} \
--statistics Sum \
--namespace AWS/Kinesis \
--dimensions Name=StreamName,Value=${stream_name} | jq .

echo "Sum bytes read from ${stream_name}"
aws --profile ${profile} cloudwatch get-metric-statistics \
--metric-name GetRecords.Bytes \
--start-time ${day_ago} \
--end-time ${now} \
--period ${full_day_secs} \
--statistics Sum \
--namespace AWS/Kinesis \
--unit Bytes \
--dimensions Name=StreamName,Value=${stream_name} | jq .
