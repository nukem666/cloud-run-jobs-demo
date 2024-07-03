module "service_apis" {
  source     = "../modules/service_apis"
  project_id = var.project_id
}

module "demo" {
  source     = "../modules/demo"
  project_id = var.project_id
  region     = var.region
  env        = var.env
}
