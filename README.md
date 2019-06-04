# vault-prometheus

## Overview

This repository will create a Vault server backed by Consul that uses Prometheus to gather metrics from Vault.

The docker compose file will launch the following containers:

* consul
* vault
* prometheus

## Configuration

To get everything working, we will need to do the following:

### Start Consul

```
$ docker-compose up -d consul
```

### Start Vault

```
$ docker-compose up -d vault
```
### Configure Vault

Initialize Vault:

```
$ export VAULT_ADDR='http://127.0.0.1:8200'
$ vault operator init -key-shares=3 -key-threshold=2 # remember to keep track of the keys somewhere
```

Unseal Vault:

```
$ vault operator unseal # do this twice with 2 different keys
```

Configure Vault:

```
$ vault login # use root token
$ vault secrets enable -path=secret/ kv
```

### Configure Prometheus

Add the root token to the `prometheus.yml` file in the `bearer_token:` section.

### Start Prometheus

```
docker-compose up -d prom
```

### Stop Containers

```
$ docker-compose stop
```

### Metrics

To learn more about Vault Telemetry, you can read about them here:

https://www.vaultproject.io/docs/internals/telemetry.html
