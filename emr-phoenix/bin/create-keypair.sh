#!/bin/bash

# cannot create a key pair with cloudformation, so will do it via bash script
# see https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-console-create-keypair.html
# source the parameters
cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

mkdir -p ../keys
aws-vault exec --assume-role-ttl="${assume_role_ttl}" --session-ttl="${session_ttl}" $profile -- aws ec2 create-key-pair --key-name "${key_name}" --query "KeyMaterial" --output text > ../keys/"${key_name}".pem
chmod 600 ../keys/*.pem