resource "google_secret_manager_secret" "db_password" {
  secret_id = "crypto-prices-db-password"
  project   = local.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password
}
