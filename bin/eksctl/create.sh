#!/bin/bash

set -x
cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

#aws-vault exec --debug "${profile}" -- \
eksctl create cluster \
  --profile "${profile}" \
  --name="${cluster_name}" \
  --region=us-east-1 \
  --zones=us-east-1b,us-east-1c \
  --version=1.15 \
  --nodes=2 \
  --auto-kubeconfig \
  --ssh-public-key="${pem_name}" \
  --node-type=t3.xlarge
