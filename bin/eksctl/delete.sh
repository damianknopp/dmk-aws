#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

eksctl delete cluster --region=us-east-1 --name="${cluster_name}" --profile="${profile}"
