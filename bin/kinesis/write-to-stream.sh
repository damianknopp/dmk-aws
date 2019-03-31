#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
version=1.0-SNAPSHOT
java -cp ../../kinesis-client/target/kinesis-client-${version}-jar-with-dependencies.jar dmk.kinesis.client.KinesisClientDriver