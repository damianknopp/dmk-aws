#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

aws-vault exec --assume-role-ttl="${assume_role_ttl}" --session-ttl="${session_ttl}" "${profile}" -- aws cloudformation update-stack --stack-name "${stack_name}" --template-body file://../cloudformation/emr-phoenix.yml