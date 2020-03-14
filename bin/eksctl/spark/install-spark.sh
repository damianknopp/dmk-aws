#!/bin/bash

set -x
cd $(dirname "${BASH_SOURCE[0]}")
source ../env.sh

kubectl --kubeconfig "${kube_config}" get nodes -o wide
kubectl --kubeconfig "${kube_config}" get crd

# https://github.com/GoogleCloudPlatform/spark-on-k8s-operator
helm repo add incubator http://storage.googleapis.com/kubernetes-charts-incubator
helm repo update

# https://github.com/GoogleCloudPlatform/spark-on-k8s-operator/issues/718
#helm install --kubeconfig "${kube_config}" --generate-name incubator/sparkoperator --namespace spark-operator --set sparkJobNamespace=default
helm install --kubeconfig "${kube_config}" --generate-name incubator/sparkoperator --namespace spark-operator

kubectl --kubeconfig "${kube_config}" get crd
helm status --kubeconfig "${kube_config}" sparkoperator-1584142787 -n spark-operator
