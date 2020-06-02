#!/usr/bin/env bash

profile=${1:-default}
cdk diff --profile "${profile}"

