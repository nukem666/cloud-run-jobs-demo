resource "google_secret_manager_secret" "demo_secret" {
  project   = var.project_id
  secret_id = "demo-secret"
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }
}

resource "google_secret_manager_secret_version" "demo_secret_version" {
  secret      = google_secret_manager_secret.demo_secret.id
  secret_data = "Secret placeholder"
}
