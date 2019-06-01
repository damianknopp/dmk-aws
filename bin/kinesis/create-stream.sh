 #!/bin/bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
shards=10
aws --profile ${profile} kinesis create-stream --stream-name ${stream_name} --shard-count ${shards}