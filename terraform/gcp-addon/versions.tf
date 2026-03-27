terraform {
  required_version = ">= 1.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.12"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.25"
    }
  }

  backend "gcs" {
    prefix = "gcp-addon"
  }
}

data "terraform_remote_state" "gcp" {
  backend = "gcs"
  config = {
    bucket = var.tfstate_bucket
    prefix = "gcp"
  }
}

data "google_client_config" "current" {}

provider "google" {
  project = local.project_id
  region  = local.region
}

provider "kubernetes" {
  host                   = "https://${local.cluster_endpoint}"
  token                  = data.google_client_config.current.access_token
  cluster_ca_certificate = base64decode(local.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${local.cluster_endpoint}"
    token                  = data.google_client_config.current.access_token
    cluster_ca_certificate = base64decode(local.cluster_ca_certificate)
  }
}

locals {
  project_id             = data.terraform_remote_state.gcp.outputs.project_id
  region                 = data.terraform_remote_state.gcp.outputs.region
  cluster_endpoint       = data.terraform_remote_state.gcp.outputs.cluster_endpoint
  cluster_ca_certificate = data.terraform_remote_state.gcp.outputs.cluster_ca_certificate
}
