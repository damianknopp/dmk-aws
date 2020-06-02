#!/usr/bin/env bash

profile=${1:-default}
cdk context --profile "${profile}" --clear

