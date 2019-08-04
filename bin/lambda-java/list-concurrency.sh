#!/bin/bash

SAVEIFS=$IFS
IFS=$'\n'
declare -a list_cmd=$(aws lambda list-functions  | jq ."Functions"[]."FunctionName" | sort)
declare -a lambdas=($list_cmd)
IFS=$SAVEIFS
for lambda in "${lambdas[@]}";
do
	lambda="${lambda%\"}"
	lambda="${lambda#\"}"
	echo "concurrency for ${lambda}"
	aws lambda get-function --function-name $lambda --output json --query Concurrency
done