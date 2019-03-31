#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

key_id=$(aws kms list-keys | jq .Keys[].KeyId | tr -d '"')
aws kms delete-custom-key-store --key-id ${key_id}