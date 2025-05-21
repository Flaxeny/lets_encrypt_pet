variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
}

variable "region" {
  default     = "nyc1"
  description = "Region to create the cluster in"
}

variable "cluster_name" {
  default     = "devops-cluster"
  description = "Name of the Kubernetes cluster"
}

variable "email" {
  description = "Email for Let's Encrypt"
  type        = string
}

