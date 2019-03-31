# AWS SQS Demo

## To build

Build at parent or this directory
`mvn clean install`

## Install dependencies
If MacOS
```
brew install jq
```
If Linux
```bash
yum install jq
```

## To run

```bash
cd $proj_root
./bin/sqs/create-queue.sh
./bin/sqs/tag-queue.sh
sleep 10
./bin/sqs/list-queues.sh
./bin/s3/create-bucket.sh
./bin/s3/copy-test-files.sh
./bin/sqs/write-to-queue.sh
```

```bash
# when finished
./bin/s3/delete-bucket.sh
./bin/sqs/purge-queue.sh
./bin/sqs/delete-queue.sh
# verify clean state
./bin/sqs/list-queues.sh
./bin/s3/head-bucket.sh
```
