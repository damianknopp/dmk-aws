
# print commands before running
set -x

cd $(dirname "${BASH_SOURCE[0]}")

export profile=default
export key_name=emr-phoenix
export stack_name=emr-phoenix-stack

# awsvault defaults
#   -t, --session-ttl=4h           Expiration time for aws session
#       --assume-role-ttl=15m      Expiration time for aws assumed role


# https://github.com/99designs/aws-vault/blob/master/USAGE.md#assuming-a-role-for-more-than-1h
# DO NOT SET ASSUME ROLE TTL > 1h
export assume_role_ttl=30m
export session_ttl=30m
