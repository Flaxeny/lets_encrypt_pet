terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.34"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "letsencrypt_cluster" {
  name    = var.cluster_name
  region  = var.region
  version = "1.32.2-do.1"

  node_pool {
    name       = "default"
    size       = "s-2vcpu-4gb"
    node_count = 2
  }
}

resource "local_file" "kubeconfig" {
  filename = "${path.module}/kubeconfig.yaml"
  content  = digitalocean_kubernetes_cluster.letsencrypt_cluster.kube_config[0].raw_config
}
