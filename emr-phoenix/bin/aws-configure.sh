
#!/bin/bash

# configure aws cli

# source the parameters
cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

aws --profile "${profile}" configure <<EOF


us-east-1
json
EOF