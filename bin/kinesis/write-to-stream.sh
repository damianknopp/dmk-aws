#!/usr/bin/env bash

basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/../env.sh
version=1.0-SNAPSHOT
kinesis_client=$basedir/../../kinesis-client
jar=$kinesis_client/target/kinesis-client-${version}.jar
java -version

if [ -f $jar ]; then
  java -cp $jar dmk.kinesis.client.KinesisClientDriver ${stream_name} ${profile}
else
  cd $kinesis_client
  mvn clean install
  java -cp $jar dmk.kinesis.client.KinesisClientDriver ${stream_name} ${profile}
fi
