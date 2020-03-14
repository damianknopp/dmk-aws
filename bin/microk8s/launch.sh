#!/bin/bash
# https://microk8s.io/

multipass launch --name microk8s-vm --mem 4G --disk 40G --cpus 4

# multipass shell microk8s-vm
# ./install.sh
# ./start.sh