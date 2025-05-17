#!/usr/bin/env bash
#
# File: https://github.com/jgpdotai/cloud-services/tree/main/tools/api-ping.sh
#

K_EMAIL="denis.arnaud_slackdml@m4x.org"
K_FIRST_NAME="Denis"
K_LAST_NAME="A."
K_COMPANY="ACME"
K_DOB="2000-01-01"
K_COMMENT="Bitol rocks!"

curl -X POST "${BITOL_URL}/v1/users" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "'"${K_EMAIL}"'",
    "password": "'"${BITOL_USER_PW}"'",
    "firstName": "'"${K_FIRST_NAME}"'",
    "lastName": "'"${K_LAST_NAME}"'",
    "company": "'"${K_COMPANY}"'",
    "dob": "'"${K_DOB}"'",
    "code": "Playground",
    "comment": "'"${K_COMMENT}"'"
}'

