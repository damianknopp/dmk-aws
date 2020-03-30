# print commands before running
set -x

cd $(dirname "${BASH_SOURCE[0]}")

export profile=dmk-api
export cluster_name=eks02
export kube_config=~/.kube/eksctl/clusters/"${cluster_name}"
export pem_name=kube01

## awsvault defaults
##   -t, --session-ttl=4h           Expiration time for aws session
##       --assume-role-ttl=15m      Expiration time for aws assumed role
## https://github.com/99designs/aws-vault/blob/master/USAGE.md#assuming-a-role-for-more-than-1h
## DO NOT SET ASSUME ROLE TTL > 1h
#export assume_role_ttl=1h
#export session_ttl=4h
