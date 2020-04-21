#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5e9e8dd2b6479d001b7b5e72/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5e9e8dd2b6479d001b7b5e72 
fi
curl -s -X POST https://api.stackbit.com/project/5e9e8dd2b6479d001b7b5e72/webhook/build/ssgbuild > /dev/null
hugo

curl -s -X POST https://api.stackbit.com/project/5e9e8dd2b6479d001b7b5e72/webhook/build/publish > /dev/null
