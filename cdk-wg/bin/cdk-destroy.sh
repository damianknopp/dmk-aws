#!/usr/bin/env bash

profile=${1:-default}
cdk destroy --profile "${profile}"

