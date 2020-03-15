#!/bin/bash
# https://microk8s.io/

multipass launch --name microk8s-vm --mem 10G --disk 60G --cpus 6

# multipass shell microk8s-vm
# ./install.sh
# ./start.sh