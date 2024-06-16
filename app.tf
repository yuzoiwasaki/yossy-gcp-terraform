resource "google_cloud_run_v2_service" "app" {
  name     = "app"
  location = "asia-northeast1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "gcr.io/${var.project_id}/cloudrun-environment-variable:v1"

      env {
        name  = "DB_HOST"
        value = "10.10.0.3"
      }

      env {
        name  = "DB_USER"
        value = "yuzo"
      }

      env {
        name  = "DB_PASSWORD"
        value = "password"
      }

      env {
        name  = "DB_NAME"
        value = "maindb"
      }
    }

    vpc_access {
      connector = google_vpc_access_connector.connector.id
      egress    = "ALL_TRAFFIC"
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role    = "roles/run.invoker"
    members = ["allUsers"]
  }
}

resource "google_cloud_run_v2_service_iam_policy" "policy" {
  location    = "asia-northeast1"
  name        = google_cloud_run_v2_service.app.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
