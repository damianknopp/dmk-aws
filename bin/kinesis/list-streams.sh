#!/bin/bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
aws kinesis list-streams | jq .