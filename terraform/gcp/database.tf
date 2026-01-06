# Cloud SQL Instance (PostgreSQL 17 for MoonPay)
resource "google_sql_database_instance" "postgres" {
  name             = "${var.app_name}-postgres"
  database_version = "POSTGRES_17"
  region           = var.region
  
  deletion_protection = false  # Set to true in production
  
  settings {
    tier              = var.db_tier
    availability_type = "REGIONAL"
    disk_size         = 10
    disk_type         = "PD_SSD"
    disk_autoresize   = true
    
    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "02:00"
      transaction_log_retention_days = 7
      location = var.region
    }
    
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.id
      ssl_mode        = "ALLOW_UNENCRYPTED_AND_ENCRYPTED"
    }
    
    database_flags {
      name  = "max_connections"
      value = "100"
    }
  }
  
  depends_on = [
    google_service_networking_connection.private_vpc_connection
  ]
}

# Cloud SQL Database (currencies for MoonPay)
resource "google_sql_database" "database" {
  name     = "currencies"
  instance = google_sql_database_instance.postgres.name
}

# Cloud SQL User
resource "google_sql_user" "user" {
  name     = "postgres"
  instance = google_sql_database_instance.postgres.name
  password = var.db_password
}
