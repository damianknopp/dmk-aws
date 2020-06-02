#!/usr/bin/env bash

profile=${1:-default}
cdk deploy --profile "${profile}"

