#!/bin/bash

microk8s.helm3 repo add microsoft https://microsoft.github.io/charts/repo
microk8s.helm3 repo update
microk8s.helm3 pull microsoft/spark --version 1.0.0
# Edit v1beta1 to app/v1
find . -name "*.yaml" -exec sed -i 's/extensions\/v1beta1/apps\/v1/' {} +
find . -name "*.yaml" -exec sed -i 's/apps\/v1beta1/apps\/v1/' {} +
# Edit values.yml
# change LoadBalancer to NodePort
# disable zepplin, if you need the resources, etc