#!/bin/bash

aws-vault exec dmk-api -- terraform destroy -var-file="main.tfvars" modules/ec2