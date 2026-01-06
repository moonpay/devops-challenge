# Secret Manager for Database URL
resource "google_secret_manager_secret" "db_url" {
  secret_id = "${var.app_name}-database-url"
 
    replication {
        user_managed {
          replicas {
            location = var.region
          }
        }
    }
  
  depends_on = [google_project_service.services]
}

resource "google_secret_manager_secret_version" "db_url" {
  secret = google_secret_manager_secret.db_url.id
  
  secret_data = "postgresql://postgres:${google_sql_user.user.password}@${google_sql_database_instance.postgres.private_ip_address}:5432/currencies"
}
