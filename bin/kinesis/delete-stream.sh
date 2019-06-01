#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

echo "Deleting ${stream_name}, this may take a few seconds"
aws --profile ${profile} kinesis delete-stream --stream-name ${stream_name}
