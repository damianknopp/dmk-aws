#!/bin/bash

#helm install nginx-ingress stable/nginx-ingress --set rbac.create=true
helm install nginx-ingress stable/nginx-ingress
kubectl --namespace default describe services/nginx-ingress-controller