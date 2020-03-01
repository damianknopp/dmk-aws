#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

#aws-vault exec --debug "${profile}" -- \ 
eksctl create cluster \
  --profile "${profile}" \
  --name="${cluster_name}" \
  --region=us-east-1 \
  --zones=us-east-1b,us-east-1c \
  --version=1.14 \
  --nodes=2 \
  --auto-kubeconfig \
  --ssh-public-key=~/keys/kube01.pem
  --node-type=t3.xlarge
