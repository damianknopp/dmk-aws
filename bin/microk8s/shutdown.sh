#!/bin/bash

microk8s.disable dns dashboard ingress registry helm3 metrics-server prometheus storage
kubectl delete service/kubernetes --namespace default