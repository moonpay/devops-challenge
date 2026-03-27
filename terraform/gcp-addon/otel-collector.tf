locals {
  otel_logs_exporters = var.otel_loki_push_url != "" ? ["loki"] : ["debug"]
  otel_exporters = merge(
    {
      debug = {
        verbosity = "basic"
      }
    },
    var.otel_loki_push_url != "" ? {
      loki = {
        endpoint = var.otel_loki_push_url
        tls = {
          insecure = true
        }
        headers = {
          "X-Scope-OrgID" = "fake"
        }
      }
    } : {}
  )
}

resource "helm_release" "otel_collector" {
  name             = "otel-collector"
  repository       = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart            = "opentelemetry-collector"
  version          = var.otel_collector_version
  namespace        = "otel"
  create_namespace = true

  values = [yamlencode({
    mode = "daemonset"

    presets = {
      logsCollection = {
        enabled = true
      }
      kubernetesAttributes = {
        enabled = true
      }
      kubeletMetrics = {
        enabled = true
      }
    }

    config = {
      receivers = {
        otlp = {
          protocols = {
            grpc = { endpoint = "0.0.0.0:4317" }
            http = { endpoint = "0.0.0.0:4318" }
          }
        }
        prometheus = {
          config = {
            scrape_configs = [
              {
                job_name        = "otel-collector"
                scrape_interval = "30s"
                static_configs  = [{ targets = ["0.0.0.0:8888"] }]
              }
            ]
          }
        }
      }

      processors = {
        batch = {
          timeout         = "5s"
          send_batch_size = 1024
        }
        memory_limiter = {
          check_interval         = "5s"
          limit_percentage       = 80
          spike_limit_percentage = 25
        }
        k8sattributes = {
          extract = {
            labels = [
              {
                tag_name = "k8s_app_component"
                key      = "app.kubernetes.io/component"
                from     = "pod"
              },
            ]
          }
        }
        resource = {
          attributes = [
            { key = "cluster", value = data.terraform_remote_state.gcp.outputs.cluster_name, action = "upsert" },
            { key = "service.namespace", from_attribute = "k8s.namespace.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.pod.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.container.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s_app_component", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.job.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.deployment.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.statefulset.name", action = "upsert" },
            { key = "service.name", from_attribute = "k8s.daemonset.name", action = "upsert" },
          ]
        }
      }

      exporters = local.otel_exporters

      service = {
        pipelines = {
          traces = {
            receivers  = ["otlp"]
            processors = ["memory_limiter", "k8sattributes", "resource", "batch"]
            exporters  = ["debug"]
          }
          metrics = {
            receivers  = ["otlp", "prometheus"]
            processors = ["memory_limiter", "k8sattributes", "resource", "batch"]
            exporters  = ["debug"]
          }
          logs = {
            receivers  = ["otlp"]
            processors = ["memory_limiter", "k8sattributes", "resource", "batch"]
            exporters  = local.otel_logs_exporters
          }
        }
      }
    }

    ports = {
      otlp = {
        enabled       = true
        containerPort = 4317
        servicePort   = 4317
        protocol      = "TCP"
      }
      otlp-http = {
        enabled       = true
        containerPort = 4318
        servicePort   = 4318
        protocol      = "TCP"
      }
    }

    resources = {
      requests = {
        cpu    = "100m"
        memory = "256Mi"
      }
      limits = {
        cpu    = "500m"
        memory = "512Mi"
      }
    }
  })]
}
