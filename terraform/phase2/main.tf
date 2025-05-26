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

data "terraform_remote_state" "phase1" {
  backend = "local"

  config = {
    path = "../phase1/terraform.tfstate"
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.phase1.outputs.cluster_endpoint
  token                  = data.terraform_remote_state.phase1.outputs.cluster_token
  cluster_ca_certificate = base64decode(data.terraform_remote_state.phase1.outputs.cluster_ca)
}

provider "helm" {
  kubernetes {
    host                   = data.terraform_remote_state.phase1.outputs.cluster_endpoint
    token                  = data.terraform_remote_state.phase1.outputs.cluster_token
    cluster_ca_certificate = base64decode(data.terraform_remote_state.phase1.outputs.cluster_ca)
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

