#!/usr/bin/env bash

# set -x

cd $( dirname "${BASH_SOURCE[0]}" )
echo "dir $(pwd)"
rm -rf ./build
mkdir -p ./build
src_files=$(find . -name "*.py" -print)
SAVEIFS=$IFS
IFS=$'\n'
src_files=($src_files)
for src_file in ${src_files[@]}; do
  zip -r build/sqs-sample-lambda . -i "${src_file}"
done

IFS=$SAVEIFS
