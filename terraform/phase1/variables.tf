variable "do_token" {
  type      = string
  sensitive = true
}
variable "region" {
  type    = string
  default = "nyc1"
}
variable "cluster_name" {
  type    = string
  default = "my-k8s-cluster"
}

