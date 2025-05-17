#!/usr/bin/env bash
#
# File: https://github.com/jgpdotai/cloud-services/tree/main/tools/api-get-contract-customer.sh
#

#
YQ_COM="$(command -v yq && echo "Y" || echo "N")"
if [ "$YQ_COM" == "N" ]
then
	echo
	echo "yq has to be installed. For instance, on MacOS, brew install yq"
	echo
	exit
fi

#
DC_ID="${BITOL_CONTRACT_ID}"
if [ "$1" != "" ]
then
	if [ "$1" == "-h" -o "$1" == "-H" -o "$1" == "--help" -o "$1" == "-help" ]
	then
		echo
		echo "Usage: $0 [<data-contract-ID>]"
		echo ".  Default contract ID: ${DC_ID}"
		echo
		exit
	fi
	DC_ID="$1"
fi

echo "Retrieving data contract (ID: ${DC_ID} - version: ${DC_SEMVER})"
curl -X GET "${BITOL_URL}/v1/contracts/${DC_ID}" \
  -H "X-API-KEY: ${BITOL_API_KEY}" \
  -H "X-USER-PASSWORD: ${BITOL_USER_PW}" \
  --output contracts/${DC_ID}.odcs.yaml

DC_SEMVER="$(cat contracts/${DC_ID}.odcs.yaml | yq -r '.version'|cut -d'v' -f2,2)"
mv contracts/${DC_ID}.odcs.yaml contracts/${DC_ID}-${DC_SEMVER}.odcs.yaml
