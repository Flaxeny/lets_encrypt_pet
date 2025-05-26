output "cluster_endpoint" {
  value = digitalocean_kubernetes_cluster.letsencrypt_cluster.endpoint
  sensitive = true
}

output "cluster_token" {
  value = digitalocean_kubernetes_cluster.letsencrypt_cluster.kube_config[0].token
  sensitive = true
}

output "cluster_ca" {
  value = digitalocean_kubernetes_cluster.letsencrypt_cluster.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_name" {
  value = data.terraform_remote_state.phase1.outputs.cluster_name
}

