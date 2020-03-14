#!/bin/bash

#kubectl proxy --accept-hosts='.*' --address=0.0.0.0 &
kubectl port-forward -n kube-system service/kubernetes-dashboard 10443:443 --address 0.0.0.0