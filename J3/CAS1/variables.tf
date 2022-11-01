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

variable "access_key" {
    type = string
    description = "access key user rdom"
}

variable "secret_key" {
    type = string
    description = "secret key user rdom"
}

variable "ssh_key" {
    type = string
    description = "ssh key user rdom"
}


variable "auth_ip" {
  type = string
  description = "Adresse IP autorisée à se connecter en SSH"
}
