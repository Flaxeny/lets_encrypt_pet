resource "null_resource" "wait_for_clusterissuer_crd" {
  provisioner "local-exec" {
    command = <<EOT
      echo "Waiting for ClusterIssuer CRD to be registered..."
      for i in {1..10}; do
        if kubectl get crd clusterissuers.cert-manager.io > /dev/null 2>&1; then
          echo " ClusterIssuer CRD is ready."
          break
        fi
        echo "Still waiting... ($i)"
        sleep 5
      done
    EOT
  }
  depends_on = [helm_release.cert_manager]
}

resource "kubernetes_manifest" "cluster_issuer" {
  manifest = yamldecode(templatefile("${path.module}/cluster-issuer.yaml", {
    email = var.email
  }))

  depends_on = [
    null_resource.wait_for_clusterissuer_crd
  ]
}

