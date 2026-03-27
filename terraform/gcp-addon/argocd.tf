resource "helm_release" "argocd" {
  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  version          = var.argocd_version
  namespace        = "argocd-system"
  create_namespace = true

  values = [yamlencode({
    configs = {
      params = {
        # Run insecure (no TLS) behind ingress/port-forward
        "server.insecure" = true
      }
    }

    server = {
      service = {
        type = "ClusterIP"
      }
    }

    # Minimal resource footprint for a small cluster
    controller = {
      resources = {
        requests = { cpu = "100m", memory = "256Mi" }
        limits   = { cpu = "500m", memory = "512Mi" }
      }
    }

    repoServer = {
      resources = {
        requests = { cpu = "50m", memory = "128Mi" }
        limits   = { cpu = "250m", memory = "256Mi" }
      }
    }

    applicationSet = {
      resources = {
        requests = { cpu = "50m", memory = "64Mi" }
        limits   = { cpu = "100m", memory = "128Mi" }
      }
    }
  })]
}
