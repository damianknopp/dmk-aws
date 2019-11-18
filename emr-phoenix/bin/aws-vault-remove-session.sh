
#!/bin/bash

# source the parameters
cd $(dirname "${BASH_SOURCE[0]}")
source ./env.sh

aws-vault remove "${profile}" -s 