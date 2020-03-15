#!/bin/bash

microk8s.start
sudo usermod -a -G microk8s ubuntu
alias kubectl=microk8s.kubectl
microk8s.enable dns dashboard ingress registry helm3 metrics-server prometheus storage