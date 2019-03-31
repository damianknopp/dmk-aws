#!/usr/bin/env bash


cd $( dirname "${BASH_SOURCE[0]}" )

rm -rf ./build
mkdir ./build

src_files=$(find . -name "*.py" -print)
zip -r build/sqs-sample-lambda "${src_files}"