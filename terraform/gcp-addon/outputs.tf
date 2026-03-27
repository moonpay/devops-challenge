output "otel_grpc_endpoint" {
  value = "otel-collector-opentelemetry-collector.otel.svc.cluster.local:4317"
}

output "otel_http_endpoint" {
  value = "otel-collector-opentelemetry-collector.otel.svc.cluster.local:4318"
}
