locals {
  env_vars = merge(var.env_vars, { DEMO_VAR_ENV = var.env })
  secret_volume = "secret-volume"
}

resource "google_cloud_run_v2_job" "demo_job" {
  project  = var.project_id
  name     = "demo-job"
  location = var.region

  template {
    template {
      containers {
        # Built-in sample image
        image = "us-docker.pkg.dev/cloudrun/container/job:latest"
        resources {
          limits = {
            cpu    = "1"
            memory = "512Mi"
          }
        }

        # Set environment variables using for_each
        dynamic "env" {
          for_each = local.env_vars
          content {
            name  = env.key
            value = env.value
          }
        }

        # Special case for secrets
        env {
          name = "DEMO_SECRET_VAR"
          value_source {
            secret_key_ref {
              secret  = google_secret_manager_secret.demo_secret.secret_id
              version = "latest"
            }
          }
        }

        volume_mounts {
          name       = local.secret_volume
          mount_path = "/secrets"
        }
      }

      volumes {
        name = local.secret_volume
        secret {
          secret       = google_secret_manager_secret.demo_secret.secret_id
          default_mode = 292
          items {
            version = "latest"
            path    = "secret.txt"
            mode    = 256
          }
        }
      }
      service_account = google_service_account.cloud_run_service_account.email
      max_retries     = 0
      timeout         = "600s"
    }
  }
}
