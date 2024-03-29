# Cloud SQL Database Instance (Second Instance)
resource "google_sql_database_instance" "second_instance" {
  depends_on = [google_service_networking_connection.private_vpc_connection]
  name             = "second-database-instance"
  region           = "europe-west1"
  database_version = "MYSQL_5_7"

  settings {
    tier = "db-f1-micro"    
    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/ccc-gr13-f23/global/networks/terraform13-network"
    }
  }
}

# Cloud SQL Database (Second Database)
resource "google_sql_database" "second_database" {
  name     = "order-database"
  instance = google_sql_database_instance.second_instance.name
}

# Cloud SQL User (Second User)
resource "google_sql_user" "second_user" {
  name     = "admin_user"
  instance = google_sql_database_instance.second_instance.name
  password = "admin_password" // Consider using a secret manager
}