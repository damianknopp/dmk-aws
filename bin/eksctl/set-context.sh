#!/bin/bash

set -x
cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

export KUBECONFIG=$KUBECONFIG:"${HOME}"/.kube/eksctl/clusters/${cluster_name}"
kubectl config use-context "${profile}"@"${cluster_name}".us-east-1.eksctl.io
