# dmk-aws
AWS client API demo

## Prerequisites
These scripts require the AWS CLI to be configured

```bash
brew install jq
brew install coreutils
pip install awscli
aws configure
```

Set credentials in ~/.aws/credentials
Give the credentials access to Kinesis, S3, SQS or subset that you are testing

## To build

```bash
mvn clean install
```

## To run
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

The file is under .gitignore but verify it is never checked into the repo

See, a Java [Kinesis Client Demo](kinesis-client/)

See, a Java [SQS Client Demo](sqs-client/)

See, [Lambdas using Python](lambda-python/)

See, a Java [SQS Lambda](sqs-lambda/)
