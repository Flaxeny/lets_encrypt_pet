resource "kubernetes_manifest" "cluster_issuer" {
  manifest = yamldecode(templatefile("${path.module}/cluster-issuer.yaml", {
    email = var.email
  }))

  depends_on = [
    helm_release.cert_manager,
    kubernetes_namespace.cert_manager
  ]
}

