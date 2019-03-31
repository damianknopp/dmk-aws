#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws lambda put-function-concurrency --function-name ${demo_function} --reserved-concurrent-executions 2
