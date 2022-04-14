# Vault-Docker

## Overview

The docker compose file will launch the following containers:

* vault


## Configuration

To get everything working, we will need to do the following:


### Start Vault


```
docker-compose up -d vault
```
### Configure Vault

Initialize Vault:

```
export VAULT_ADDR='http://127.0.0.1:8200' 
or
export VAULT_ADDR=http://localhost:8200/

vault operator init -format=json > init.json # remember to keep track of the keys somewhere
```

Unseal Vault:

```
vault operator unseal # do this with 3 different keys
```

Configure Vault:

```
vault login # use root token
vault secrets enable -path=secret/ kv
```

Stop container
```
docker-compose stop
```
