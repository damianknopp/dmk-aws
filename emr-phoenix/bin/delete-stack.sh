#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

aws-vault exec "${profile}" -- aws cloudformation delete-stack --stack-name "${stack_name}"