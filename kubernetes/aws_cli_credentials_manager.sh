#!/bin/bash

cat << EOF | grep -v '^#' | awk 'BEGIN { RS = ""; ORS = "\n\n" } { print }' > ~/.aws/credentials
#
# Set AWS credentials here
# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-files.html#cli-configure-files-format-profile
#
# Example of using general
# [default] # DefaultProfile
# aws_access_key_id = AKIAIOSFODNN7EXAMPLE # Specify AWS Access Key ID
# aws_secret_access_key = wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY # Specify AWS Secret Access Key
# region = ap-northeast-1 # Specify the region to be used
#
[default]
aws_access_key_id = REPLACE_ME
aws_secret_access_key = REPLACE_ME
region = REPLACE_ME

EOF

exit 0
