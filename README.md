# vault-prometheus

## Overview

The docker compose file will launch the following containers:

* vault
* prometheus
* Grafana

## Configuration

To get everything working, we will need to do the following:

### Add this block in vault configuration file 

```
telemetry {
  prometheus_retention_time = "5m",
  disable_hostname = true
}
```
### Start Vault


```
$ docker-compose up -d vault
```
### Configure Vault

Initialize Vault:

```
$ export VAULT_ADDR='http://127.0.0.1:8200'
$ vault operator init -key-shares=1 -key-threshold=1 -format=json > init.json # remember to keep track of the keys somewhere
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

Enable Audit File

```
$ vault audit enable file file_path=/vault/logs/vault-audit.log mode=744
```

Enable metrics

Usage metrics are a feature that is enabled by default for Vault Enterprise but disabled for open source.

To enable usage tracking for open source, use the sys/internal/counters/config endpoint. (This step is NOT necessary for Vault Enterprise.)

```
vault write sys/internal/counters/config enabled=enable

```


Create Policy for prometeus

```
$ vault policy write prometheus-metrics - << EOF
path "/sys/metrics" {  capabilities = ["read","write"] }
EOF

```

Create prometus Token using the policy

```
$ vault token create \
  -field=token \
  -policy prometheus-metrics 

```
 
### Configure Prometheus

Add the root token to the `prometheus.yml` file in the `bearer_token:` section.

### Start Prometheus

```
docker-compose up -d prom
```

You can access the Prometheus UI at `http://localhost:9090`

### Configure Grafana

Add the Url to the `datasource.yml` file in the `url:` section. example `http://docker.for.mac.localhost:9090`

### Start Grafana

```
docker-compose up -d grafa
```

### Add Dashboard on Grafana

- Press icon +

- Select import 

- Import  with ID the number from this page https://grafana.com/grafana/dashboards/12904

- Select vault as datasource 


### Stop Containers

```
$ docker-compose stop
```

### Metrics

To learn more about Vault Telemetry, you can read about them here:

https://www.vaultproject.io/docs/internals/telemetry.html
