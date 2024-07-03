variable "project_id" {
  type = string
}

variable "apis" {
  description = "List of APIs to enable"
  type        = map(string)
  default = {
    cloud_run       = "run.googleapis.com"
    secrets_manager = "secretmanager.googleapis.com"
  }
}