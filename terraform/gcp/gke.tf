module "gke" {
  source  = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  version = "~> 33.0"

  project_id = var.project_id
  name       = var.cluster_name
  region     = var.region

  network           = google_compute_network.vpc.name
  subnetwork        = google_compute_subnetwork.subnet.name
  ip_range_pods     = "${var.cluster_name}-pods"
  ip_range_services = "${var.cluster_name}-services"

  release_channel        = "REGULAR"
  enable_private_nodes   = true
  master_ipv4_cidr_block = "172.16.0.0/28"

  # Private nodes but public control plane so we can reach it from CI / local
  enable_private_endpoint = false

  deletion_protection = false

  # OTel collector handles logging and monitoring -- disable GKE managed agents
  logging_service    = "none"
  monitoring_service = "none"

  horizontal_pod_autoscaling = true
  http_load_balancing        = true

  node_pools = [
    {
      name         = "default"
      machine_type = var.node_machine_type
      min_count    = var.min_node_count
      max_count    = var.max_node_count
      disk_size_gb = 30
      disk_type    = "pd-standard"
      auto_repair  = true
      auto_upgrade = true
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}
