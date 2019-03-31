# AWS Demo


## To build

```bash
mvn clean install
```

## To run

```bash
../bin/s3/create-bucket.sh
../bin/s3/copy-test-files.sh
../bin/lambda-java/stage-demo-function.sh
../bin/lambda-java/create-demo-function.sh
../bin/lambda-java/set-concurrency.sh
../bin/lambda-java/sqs-trigger.sh
```

## To cleanup

```bash
../bin/s3/delete-bucket.sh
../bin/lambda-java/delete-demo-function.sh
```