# AWS Demo

## Install dependencies
Download and install [terraform](https://www.terraform.io/)

## Layout
This project has a structure subdirectories with independent terraform states

## To run

cd to the directory 
```bash
cd lambda/setup
AWS_PROFILE=default terraform init
AWS_PROFILE=default terraform apply
```
type yes, if you agree with the plan presented, notice the +/- in front of the resources


## To cleanup
```bash
AWS_PROFILE=default terraform destroy
```
