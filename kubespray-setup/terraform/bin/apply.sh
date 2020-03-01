#!/bin/bash

aws-vault exec dmk-api -- terraform apply -var-file="main.tfvars" modules/ec2