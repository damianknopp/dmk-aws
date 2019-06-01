# AWS Demo

This directory contains a collection of bash scripts to run the demo


# To run
Most times you would use the IAM role of your deployed instance to run code. However these script use a local configured profile for development

To use, create a `$proj_root/bin/acct.sh` file in the form of

```
acct=aws_account_id
profile=default
```

To get your account id;

```bash
aws --profile default sts get-caller-identity
```