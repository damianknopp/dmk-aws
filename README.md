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
Create a ./bin/acct.sh file and enter one line with your account number `acct=1234`. The file is under .gitignore but verify it is never checked into the repo

See, [Kinesis Demo](kinesis-client/README.md)

See, [SQS Demo](sqs-client/README.md)
