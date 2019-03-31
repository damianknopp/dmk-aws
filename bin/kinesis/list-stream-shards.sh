 #!/bin/bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
shards=10
aws kinesis list-shards --stream-name ${stream_name}

