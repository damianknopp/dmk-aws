#!/bin/bash

kubectl run -it dnstools --image=infoblox/dnstools --restart=Never --rm
# curl -k 'https://dmk-ing-nginx-ingress/nginx-health'
