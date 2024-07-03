terraform {
  backend "gcs" {
    bucket = "sacred-age-412000-terraform"
    prefix = "sandbox/crj-demo"
  }
}