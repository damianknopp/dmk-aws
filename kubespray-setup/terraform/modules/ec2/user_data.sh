#!/bin/bash

sudo apt update
# sudo apt upgrade
sudo apt install chrony -y && chronyc activity
sudo apt install python3-pip -y
sudo pip3 install --user awscli
sudo ~/.local/bin/aws configure <<EOF


us-east-1
json
EOF

# sudo cat /var/log/cloud-init-output.log 
# sudo ~/.local/bin/aws ec2 describe-iam-instance-profile-associations
