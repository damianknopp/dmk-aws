#!/usr/bin/env bash


cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh


# LATEST, TRIM_HORIZON
shard_itr_type=TRIM_HORIZON
shard_id=shardId-000000000000
shard_itr=$(aws kinesis get-shard-iterator --stream-name ${stream_name} --shard-id ${shard_id} --shard-iterator-type ${shard_itr_type} | jq ."ShardIterator" )
echo "found shard iterator for shard 0 ${shard_itr}"

limit=2
aws kinesis get-records --shard-iterator ${shard_itr} --limit ${limit} | jq .
#data=$(aws kinesis get-records --shard-iterator ${shard_itr} --limit ${limit} | jq ."Records"[]."Data")
#next_itr=$(aws kinesis get-records --shard-iterator ${shard_itr} --limit ${limit} | jq ."Records"[]."NextShardIterator")
#echo "Next iterator is ${next_itr}"

data="Mw=="
data_raw=$(echo ${data} | base64 -D -)
echo "Record unencoded is ${data_raw}"
