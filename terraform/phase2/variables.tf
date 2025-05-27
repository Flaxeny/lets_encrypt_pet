variable "email" {
  description = "Email address for Let's Encrypt registration"
  type        = string
}

variable "cluster_endpoint" {
  type        = string
  description = "Kubernetes cluster endpoint"
}

variable "cluster_token" {
  type        = string
  description = "Kubernetes cluster token"
  sensitive   = true
}

variable "cluster_ca" {
  type        = string
  description = "Kubernetes cluster CA"
  sensitive   = true
}

