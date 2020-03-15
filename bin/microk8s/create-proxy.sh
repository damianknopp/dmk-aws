#!/bin/bash
#kubectl proxy --accept-hosts='.*' --address=0.0.0.0 &

microk8s.kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0
microk8s.kubectl port-forward service/dmk-spark-livy 8998:8998 --address 0.0.0.0
microk8s.kubectl port-forward service/dmk-spark-webui 8080:8080 --address 0.0.0.0