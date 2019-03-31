#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

key_id=$(aws kms list-keys | jq .Keys[].KeyId | tr -d '"')
aws kms describe-key --key-id ${key_id}