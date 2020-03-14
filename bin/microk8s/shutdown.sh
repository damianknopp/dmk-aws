#!/bin/bash

microk8s.disable dns dashboard ingress registry
kubectl delete service/kubernetes --namespace default