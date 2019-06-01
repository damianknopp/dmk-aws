#!/bin/bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
aws --profile ${profile} kinesis list-streams | jq .