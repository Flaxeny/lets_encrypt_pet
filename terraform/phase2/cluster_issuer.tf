resource "kubernetes_manifest" "cluster_issuer" {
  manifest = yamldecode(file(var.cluster_issuer_path))

  depends_on = [helm_release.cert_manager]
}

