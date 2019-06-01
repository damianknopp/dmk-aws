# AWS Kinesis Demo

## To build

Build at parent or this directory
`mvn clean install`

## Install dependencies
If MacOS
```
brew install coreutils
brew install jq
```
If Linux
```bash
yum install jq
```

## To run

Add a `$proj_root/bin/acct.sh` file in the form of
```
acct=aws_account_id
profile=default
```

```
cd $proj_root
./bin/kinesis/list-streams.sh
./bin/kinesis/create-stream.sh
./bin//kinesis/add-tags-to-stream.sh 
./bin/kinesis/list-tags.sh
./bin/kinesis/write-to-stream.sh
./bin/kinesis/list-rw-metrics.sh
./bin/kinesis/list-stream-shards.sh
./bin/kinesis/get-records.sh
./bin/kinesis/list-rw-metrics.sh
# when finished
./bin/kinesis/delete-stream.sh
./bin/kinesis/list-streams.sh
```
