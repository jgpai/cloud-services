Equivalent to steps on [Experimenting with Data Contracts](https://medium.com/@jgperrin/9d36219e139e)

* **OS** : Microsoft Windows 11 Enterprise
* **Terminal** : Windows Command Prompt
* **cURL version** : 8.12.1 (Windows)

# Setting up the playground
For simplicity, I will export all key values as environment variables, so it will be easier to copy/paste the curl calls (which can be tedious).

```
set BITOL_URL=https://cloud.jgp.ai/api
set BITOL_USER_PW=BitolRu7ez!
set BITOL_USER_EMAIL=jgp@jgp.net
```

Ok, you can use the same password if you want, but **do not use the same email**. A real email is needed. And there it goes, create your account.

> [!WARNING]
> I wasn't able to split the JSON object across multiple lines
```
curl -X POST "%BITOL_URL%/v1/users" ^
  --json "{ \"email\": \"%BITOL_USER_EMAIL%\", "\"password\": \"%BITOL_USER_PW%\", \"firstName\": \"<<Your first name>>\", \"lastName\": \"<<Your last name>>\", \"company\": \"<<Your company>>\", \"dob\": \"<<Your date of birth>>\", \"code\": \"Playground\", \"comment\": \"<<Something nice is always appreciated.>>\" }"
```

If you don't feel chatty, only the email & password are required. The service should reply something like:

```
{"email":"jgp@jgp.net",
"firstName":"Jean-Georges",
"lastName":"Perrin",
"company":"Bitol",
"dob":null,
"comment":"I love Building Data Products.",
"createdAt":"2025-04-25T15:50:29.650725", 
"updatedAt":"2025-04-25T15:50:29.650736",
"apiKey":"97d09209-9021-4b24-89a9-620aae063d40"}
```

The important part is the API key: `97d09209–9021–4b24–89a9–620aae063d40`, which I recommend exporting as well.

```
set BITOL_API_KEY=97d09209-9021-4b24-89a9-620aae063d40
```

At this stage, you should have received an email with instructions on how to validate your account. Do not forget to do it!

# Let's create our first contract!
If we want to build a data product, let’s start with our promise, or the data contract. I will use the basic example of a client and their addresses.

I will simply send the DDL of my database to the service, and it will create the embryo of the data contract for me.

```
type customers.sql | curl -X POST "%BITOL_URL%/v1/contracts?sourceFormat=DDL&version=0.1.0&name=CustomerContract&domain=Customer&tenant=QuantumClimate" ^
  -H "X-API-KEY: %BITOL_API_KEY%" ^
  -H "X-USER-PASSWORD: %BITOL_USER_PW%" ^
  -F "file=@-"
```

Let’s analyze the call:
* `sourceFormat=DDL` specifies that the format of the source the service is getting is the DDL.
* `version=0.1.0` specifies a semantic version ([semver](https://semver.org/)) number. Non-semantic versioning is not supported.
* `name=CustomerContract` is the name of the contract.
* `domain=Customer` is the business domain associated with this contract.
* `tenant=QuantumClimate` a specific tenant (or brand, or business unit, or department… ).
The result should look like:

```
{
  "domain":"Customer",
  "name":"CustomerContract",
  "id":"34cae6d7-7648-38b2-8f66-8db79e1e2ce4",
  "version":"0.1.0",
  "tenant":"QuantumClimate",
  "status":"draft"
}
```

The contract's identifier is `34cae6d7–7648–38b2–8f66–8db79e1e2ce4`, and you should have the same one as the service is designed to be idempotent. Like the other elements, let’s export it to the environment:

```
set BITOL_CONTRACT_ID=34cae6d7-7648-38b2-8f66-8db79e1e2ce4
```
Now I can retrieve the contract:
```
curl -X GET "%BITOL_URL%/v1/contracts/%BITOL_CONTRACT_ID%" ^
  -H "X-API-KEY: %BITOL_API_KEY%" ^
  -H "X-USER-PASSWORD: %BITOL_USER_PW%"
```
Or, if I want it in a file:
```
curl -X GET "%BITOL_URL%/v1/contracts/%BITOL_CONTRACT_ID%" ^
  -H "X-API-KEY: %BITOL_API_KEY%" ^
  -H "X-USER-PASSWORD: %BITOL_USER_PW%" ^
  --output %BITOL_CONTRACT_ID%-0.1.0.odcs.yaml
```
If you look at the file, you should get something like:
```
apiVersion: "v3.0.2"
contractCreatedTs: "2025-05-09T21:34:58.759+00:00"
dataProduct: ""
description:
  usage: "DDL upload for contract generation"
  purpose: "Defines schema based on uploaded DDL"
  limitations: "None"
domain: "Customer"
id: "34cae6d7-7648-38b2-8f66-8db79e1e2ce4"
kind: "DataContract"
name: "CustomerContract"
schema:
- logicalType: "object"
  name: "Customer"
  physicalName: "Customer"
  physicalType: "table"
  properties:
  - logicalType: "number"
    name: "customer_id"
    physicalName: "customer_id"
    physicalType: "SERIAL"
    primaryKey: true
    required: true
...
status: "draft"
team:
- description: "Automatically generated"
  dateIn: "2025-05-09T21:34:58.760Z"
  email: "jgp@jgp.net"
  name: "Jean-Georges Perrin"
  role: "DPO"
  username: "jgp@jgp.net"
tenant: "QuantumClimate"
version: "v0.1.0"
```
You can now edit, enrich, and more, following the [Bitol ODCS specs](https://github.com/bitol-io/open-data-contract-standard). Once you're done, upload it to the service:
```
curl -X POST "%BITOL_URL%/v1/contracts?version=0.1.1" ^
  -H "X-API-KEY: %BITOL_API_KEY%" ^
  -H "X-USER-PASSWORD: %BITOL_USER_PW%" ^
  -F "file=@./%BITOL_CONTRACT_ID%-0.1.0.odcs.yaml"
```
