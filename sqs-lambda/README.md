# AWS Demo

Simple Lambda to read messages from SQS and read from S3 (WIP)

## To build

```bash
mvn clean install
```

## Initialize AWS environment
```bash
../bin/s3/create-bucket.sh
cd aws-setup-terraform
terraform init
terraform apply
```

## To run

```bash
../bin/s3/copy-test-files.sh
../bin/lambda-java/stage-demo-function.sh
../bin/lambda-java/create-demo-function.sh
../bin/lambda-java/set-concurrency.sh
../bin/sqs/create-queue.sh
../bin/lambda-java/sqs-trigger.sh
../bin/sqs/write-to-queue.sh
```

## To cleanup

```bash
cd aws-setup-terraform
terraform destroy
```

```bash
../bin/sqs/purge-queue.sh
../bin/sqs/delete-queue.sh
../bin/s3/delete-bucket.sh
../bin/lambda-java/delete-demo-function.sh
```