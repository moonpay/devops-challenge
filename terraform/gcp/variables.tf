variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "europe-west2"
}

variable "cluster_name" {
  type    = string
  default = "crypto-prices"
}

variable "node_machine_type" {
  type    = string
  default = "e2-small"
}

variable "min_node_count" {
  type    = number
  default = 1
}

variable "max_node_count" {
  type    = number
  default = 2
}
