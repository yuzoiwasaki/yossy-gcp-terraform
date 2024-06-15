resource "google_cloud_run_v2_service" "app" {
  name     = "app"
  location = "asia-northeast1"
  ingress  = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = "gcr.io/${var.project_id}/cloudrun-sample:v1"
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
