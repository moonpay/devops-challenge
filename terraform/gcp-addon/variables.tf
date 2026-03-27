variable "tfstate_bucket" {
  description = "GCS bucket name where the gcp/ layer stores its state"
  type        = string
}

variable "otel_collector_version" {
  type    = string
  default = "0.82.0"
}

variable "cert_manager_version" {
  type    = string
  default = "1.14.5"
}

variable "external_secrets_version" {
  type    = string
  default = "0.9.13"
}

variable "argocd_version" {
  type    = string
  default = "7.8.13"
}

variable "db_password" {
  description = "Database password stored in GCP Secret Manager"
  type        = string
  sensitive   = true
}

variable "otel_loki_push_url" {
  type        = string
  description = "Loki HTTP push URL for the collector logs pipeline"
  default     = "http://crypto-prices-loki.crypto-prices.svc.cluster.local:3100/loki/api/v1/push"
}
