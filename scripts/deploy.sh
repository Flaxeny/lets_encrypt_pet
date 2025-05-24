#!/bin/bash
set -e

echo "[Phase 1] Applying Terraform (cluster + cert-manager)…"
cd terraform/phase1
terraform init
terraform apply -auto-approve
terraform output -raw kubeconfig > ~/.kube/config
chmod 600 ~/.kube/config
cd ..

echo "[Phase 2] Applying Terraform (ClusterIssuer)…"
cd terraform/phase2
terraform init
terraform apply -auto-approve
cd ..

echo "✅ All done!"

