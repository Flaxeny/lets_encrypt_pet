terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.7"
    }
  }
}

provider "kubernetes" {
  config_path = "${path.module}/kubeconfig"
}

provider "helm" {
  kubernetes {
    config_path = "${path.module}/kubeconfig"
  }
}


resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  create_namespace = true
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "v1.14.3"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "null_resource" "apply_cluster_issuer" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.cluster_issuer_path} --kubeconfig ${path.module}/kubeconfig"
  }
}

