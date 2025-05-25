#!/bin/bash
set -e

echo "[Phase 2] Applying Terraform (Cert-Manager ClusterIssuer)…"

cd terraform/phase2

# Проверка, что kubeconfig существует
if [ ! -f ~/.kube/config ]; then
  echo "❌ kubeconfig не найден. Убедитесь, что вы выполнили doctl kubernetes cluster kubeconfig save <cluster-name>"
  exit 1
fi

terraform init
terraform apply -auto-approve

cd ..

echo "✅ Cert-Manager и ClusterIssuer применены!"

