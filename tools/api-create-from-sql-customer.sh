#!/usr/bin/env bash
#
# File: https://github.com/jgpdotai/cloud-services/tree/main/tools/api-create-from-sql-customer.sh
#

cat resources/customer.sql | \
curl -X POST "${BITOL_URL}/v1/contracts?sourceFormat=DDL&version=0.1.0&\
name=CustomerContract&domain=Customer&tenant=QuantumClimate" \
     -H "X-API-KEY: ${BITOL_API_KEY}" \
     -H "X-USER-PASSWORD: ${BITOL_USER_PW}" \
     -F "file=@-"
