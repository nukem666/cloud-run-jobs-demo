locals {
  roles = toset(["run.invoker", "iam.serviceAccountUser", "secretmanager.secretAccessor"])
}

resource "google_service_account" "cloud_run_service_account" {
  project      = var.project_id
  account_id   = "cloud-run-job-sa"
  display_name = "Cloud Run Job Service Account"
}

resource "google_project_iam_member" "cloud_run_roles" {
  for_each = local.roles
  project  = var.project_id
  role     = "roles/${each.value}"
  member   = "serviceAccount:${google_service_account.cloud_run_service_account.email}"
}
