#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws --profile ${profile} lambda delete-function --function-name ${demo_function}