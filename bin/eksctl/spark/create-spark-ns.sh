#!bin/bash

set -x
cd $(dirname "${BASH_SOURCE[0]}")
source ../env.sh

kubectl --kubeconfig "${kube_config}" apply -f spark-op-ns.json