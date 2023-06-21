variable "org_name" {}
variable "base_url" {}
variable "api_token" {}

variable "env" {
  type        = string
  description = "The app environment"
}

variable "url" {
  type        = string
  description = "The url to use"
}