#!/usr/bin/env bash
#
# File: https://github.com/jgpdotai/cloud-services/tree/main/tools/api-post-contract-customer.sh
#

curl -X POST "$BITOL_URL/v1/contracts?version=0.1.1" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW" \
  -F "file=@contracts/$BITOL_CONTRACT_ID-0.1.0.odcs.yaml"


