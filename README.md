# jgp.ai's Cloud Services

Thanks for your interest!

Check the [EULA](https://github.com/jgpdotai/cloud-services/blob/main/eula.md), it's important.

# Tutorials

1. [Experimenting with Data Contracts](https://medium.com/data-mesh-learning/experimenting-with-data-contracts-9d36219e139e)
2. Playing with Data Products
3. Other API calls

# Surveys

1. [Initial registration survey](https://jgp.ai/csreg).

# Reference material

## Development environment

```bash
export BITOL_URL=https://cloud.jgp.ai/api
export BITOL_USER_PW=BitolRu7ez!
export BITOL_USER_EMAIL=jgp@jgp.net
export BITOL_API_KEY=97d09209-9021-4b24-89a9-620aae063d40

export BITOL_CONTRACT_ID=6aeafdc1-ed62-4c8f-bf0a-da1061c98cdb
```

## Create a new user and its API key

Note the syntax of the environment variables when they are used inside a payload.

```bash
curl -X POST "$BITOL_URL/v1/users" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "'"$BITOL_USER_EMAIL"'",
    "password": "'"$BITOL_USER_PW"'"
}'
```

```bash
curl -X POST "$BITOL_URL/v1/users" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "firstName": "John",
    "lastName": "Doe",
    "company": "Example Inc",
    "dob": "1990-01-01",
    "comment": "This is a test user."
}'
```

This will return an API KEY that you can assign to an environment variable:

```bash
export BITOL_API_KEY=97d09209-9021-4b24-89a9-620aae063d40
```

**All calls** will require the API key. Some altering & reading calls will also **require the user password**.

```bash
curl -X GET "$BITOL_URL/v1/users/<user id>" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

## Data Contract

### Creation

Happy path:

```bash
curl -X POST "$BITOL_URL/v1/contracts" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -F "file=@resources/postgresql-adventureworks-contract.odcs.yaml"
```

With a specific version:

```bash
curl -X POST "$BITOL_URL/v1/contracts?version=1.2.3" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -F "file=@resources/postgresql-adventureworks-contract.odcs.yaml"
```

Error: not a YAML file.

```bash
curl -X POST "$BITOL_URL/v1/contracts" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -F "file=@resources/text.txt"
```

Error: not a contract.

```bash
curl -X POST "$BITOL_URL/v1/contracts" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -F "file=@resources/not-a-contract.odcs.yaml"
```

### Creation from a DDL

```bash
cat src/test/resources/ddl/air-booking-basic.sql \
curl -X POST "$BITOL_URL/v1/contracts?sourceFormat=DDL&version=0.1.0&name=MyDDLContract&domain=Finance&tenant=Acme" \
     -H "X-API-KEY: $BITOL_API_KEY" \
     -H "X-USER-PASSWORD: $BITOL_USER_PW" \
     -F "file=@-"
```

### Get all contract headers for a specific user

Returns only the header of all the specified user.

```bash
curl -X GET "$BITOL_URL/v1/contracts" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```  

### Get a contract

Returns specifically a version.

```bash
curl -X GET "$BITOL_URL/v1/contracts/$BITOL_CONTRACT_ID?version=1.0.0" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

Returns the latest version.

```bash
curl -X GET "$BITOL_URL/v1/contracts/$BITOL_CONTRACT_ID" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

Returns only the header of the latest version.

```bash
curl -X GET "$BITOL_URL/v1/contracts/$BITOL_CONTRACT_ID?format=HEADER" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

Returns the DDL extracted from the data contract, tailored for PostgreSQL.

```bash
curl -X GET "$BITOL_URL/v1/contracts/$BITOL_CONTRACT_ID?format=DDL&subformat=PostgreSQL" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

Returns an ugly PDF of the data contract.

```bash
curl -X GET "$BITOL_URL/v1/contracts/$BITOL_CONTRACT_ID?format=PDF" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW" \
  --output test.pdf
```

Returns a pretty PDF of the data contract.

Coming soon!

## Data Products

### Creation from a data contract

```bash
curl -X POST "$BITOL_URL/v1/products?contractId=$BITOL_CONTRACT_ID&contractVersion=1.0.0" \
  -H "X-API-KEY: $BITOL_API_KEY"
```

### Creation by uploading a data product

```bash
curl -X POST "$BITOL_URL/v1/products?version=0.1.1" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -F "file=@./src/test/resources/data-product/dataprod.odps.yaml"
```

### Read

```bash
curl -X GET "$BITOL_URL/v1/products?contractId=$BITOL_PRODUCT_ID" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW" \
  --output $BITOL_PRODUCT_ID-0.1.0.odcs.yaml
```

## Admin operations

Limited to admin users

### Retrieve logs

```bash
curl -X GET "$BITOL_URL/v1/logs?limit=5" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```

### Check health

```bash
curl -X GET "$BITOL_URL/v1/health" \
  -H "X-API-KEY: $BITOL_API_KEY" \
  -H "X-USER-PASSWORD: $BITOL_USER_PW"
```
