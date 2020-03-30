#!/bin/bash

# helm repo add nginx-stable https://helm.nginx.com/stable
# helm install nginx-ingress stable/nginx-ingress
# https://docs.nginx.com/nginx-ingress-controller/installation/running-multiple-ingress-controllers/
# --set controller.pod.annotations={}
# --set controller.watchNamespace=<ns>
# --set prometheus.create=true
# --set rbac.create=true
# --set controller.replicaCount=2
# --set controller.healthStatus=true
# helm upgrade dmk-ing nginx-stable/nginx-ingress --set prometheus.create=true --set controller.healthStatus=true
kubectl --namespace default describe services/nginx-ingress-controller

