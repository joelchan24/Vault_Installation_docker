ui=true

storage "file" {
  path    = "/vault/data"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

telemetry {
  prometheus_retention_time = "5m",
  disable_hostname = true
}

disable_mlock = true
