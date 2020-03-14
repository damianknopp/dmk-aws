#!/bin/bash

set -x
cd $(dirname "${BASH_SOURCE[0]}")
source ../env.sh


# https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/tree/master/examples
kubectl --kubeconfig "${kube_config}" apply -f ./spark/spark-pi.yaml