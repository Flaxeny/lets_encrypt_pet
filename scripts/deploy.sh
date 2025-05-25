#!/bin/bash
set -euo pipefail

PHASE_DIR="terraform/phase2"
KUBECONFIG_PATH="$HOME/.kube/config"

echo -e "\n [Phase 2] Установка Cert-Manager и ClusterIssuer через Terraform…"

# Проверка наличия terraform
if ! command -v terraform &> /dev/null; then
  echo " Terraform не установлен. Установите его и повторите попытку."
  exit 1
fi

# Проверка наличия kubectl
if ! command -v kubectl &> /dev/null; then
  echo " kubectl не установлен. Установите его и повторите попытку."
  exit 1
fi

# Проверка наличия kubeconfig
if [ ! -f "$KUBECONFIG_PATH" ]; then
  echo " kubeconfig не найден. Выполните:"
  echo "   doctl kubernetes cluster kubeconfig save <cluster-name>"
  exit 1
fi

# Проверка подключения к кластеру
if ! kubectl cluster-info &> /dev/null; then
  echo " Не удалось подключиться к кластеру. Проверьте kubeconfig."
  exit 1
fi

# Переход в директорию с Terraform
cd "$PHASE_DIR"

# Инициализация и применение
terraform init -input=false
terraform apply -auto-approve

cd - > /dev/null

echo -e "\n Cert-Manager и ClusterIssuer успешно применены!"

