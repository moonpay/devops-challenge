resource "google_service_account" "cloudrun" {
  account_id   = "sa-${var.app_name}-cloudrun"
  display_name = "Cloud Run Service Account"
}

# IAM for Cloud Run service account
resource "google_project_iam_member" "cloudrun_roles" {
  for_each = toset([
    "roles/cloudsql.client",
    "roles/secretmanager.secretAccessor",
  ])
  
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudrun.email}"
}

resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_v2_service.app.location
  service  = google_cloud_run_v2_service.app.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
