#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws --profile ${profile} kinesis add-tags-to-stream --stream-name ${stream_name} --tags ${tags}