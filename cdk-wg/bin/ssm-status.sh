#!/usr/bin/env bash

instance=${1:-unk}
profile=${2:-default}
aws --profile "${profile}" ssm describe-instance-information --filter "Key=InstanceIds,Values=${instance}"

