# dmk-aws
AWS client API demo

## Prerequisites
These scripts require the AWS CLI to be configured

```bash
brew install jq
brew install coreutils
pip install awscli
aws configure
# set credentials in ~/.aws/credentials
# give the credentials access to Kinesis, S3, SQS or subset that you are testing
```

## To build

```bash
mvn clean install
```

## To use
Create a `$proj_root/bin/acct.sh` file in the form of
```
acct=aws_account_id
profile=default
```

The file is under .gitignore but verify it is never checked into the repo

See, a Java [Kinesis Client Demo](kinesis-client/README.md)

See, a Java [SQS Client Demo](sqs-client/README.md)

See, [Lambdas using Python](lambda-python/README.md)

See, a Java [SQS Lambda](sqs-lambda/README.md)
