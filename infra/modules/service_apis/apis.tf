resource "google_project_service" "enabled_apis" {
  for_each                   = var.apis
  project                    = var.project_id
  service                    = each.value
  disable_dependent_services = true
  disable_on_destroy         = false
}
