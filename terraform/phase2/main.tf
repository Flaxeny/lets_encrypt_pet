terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.13"
    }
  }
}

provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_ca)
}

provider "helm" {
  kubernetes {
    host                   = var.cluster_endpoint
    token                  = var.cluster_token
    cluster_ca_certificate = base64decode(var.cluster_ca)
  }
}

resource "kubernetes_namespace" "cert_manager" {
  metadata {
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = kubernetes_namespace.cert_manager.metadata[0].name
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.14.3"

  set {
    name  = "installCRDs"
    value = "true"
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      set,
      version
    ]
  }

  depends_on = [kubernetes_namespace.cert_manager]
}


