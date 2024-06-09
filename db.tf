resource "google_sql_database_instance" "main" {
  project          = var.project_id
  name             = "main-db"
  region           = "asia-northeast1"
  database_version = "MYSQL_8_0"

  settings {
    tier = "db-f1-micro"

    ip_configuration {
      private_network = google_compute_network.vpc_network.id
      ipv4_enabled    = false
    }
  }
}

resource "google_sql_user" "yuzo" {
  project = var.project_id

  name     = "yuzo"
  instance = google_sql_database_instance.main.name
  password = "password"
}

resource "google_sql_database" "maindb" {
  project = var.project_id

  name     = "maindb"
  instance = google_sql_database_instance.main.name
}
