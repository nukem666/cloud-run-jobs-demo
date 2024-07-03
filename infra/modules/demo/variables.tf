variable "project_id" {
  type = string
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "env_vars" {
  description = "Map of environment variables for the Cloud Run job"
  type        = map(string)
  default = {
    DEMO_VAR_0 = "0"
    DEMO_VAR_1 = "1"
    DEMO_VAR_2 = "2"
    DEMO_VAR_3 = "3"
    DEMO_VAR_4 = "4"
    DEMO_VAR_5 = "5"
    DEMO_VAR_6 = "6"
    DEMO_VAR_7 = "7"
    DEMO_VAR_8 = "8"
    DEMO_VAR_9 = "9"
  }
}
