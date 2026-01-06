variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "app_name" {
  description = "The application name"
  type        = string
}
variable "environment" {
  description = "The deployment environment (e.g., production, staging)"
  type        = string
}
variable "machine_type" {
  description = "The machine type for Cloud Run instances"
  type        = string
}
variable "min_instances" {
  description = "Minimum number of instances for Cloud Run"
  type        = number
}
variable "max_instances" {
  description = "Maximum number of instances for Cloud Run"
  type        = number
}
variable "db_tier" {
  description = "The machine type for Cloud SQL instance"
  type        = string
}
variable "db_password" {
  description = "The password for the database user"
  type        = string
}
