variable "zone" {
  type = string
}

variable "region" {
  type = string
}

variable "env" {
  type = string
}

variable "project_id" {
  type        = string
  description = "Your project ID"
}

variable "auth_token" {
    type = string
    description = "Scaleway authtentication token used in the function"
}


variable "instance_count" {
  default = "2"
}

variable "instance_type" {
  default = "DEV1-S"
}