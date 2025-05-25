#  Руководство по ручному развёртыванию проекта Let's Encrypt в DOKS

Этот проект состоит из двух фаз:

- **Phase 1** — развёртывание DOKS кластера и базовой инфраструктуры через Terraform.
- **Phase 2** — установка Cert-Manager и ClusterIssuer для автоматического управления TLS-сертификатами.

---

##  Фаза 1: Развёртывание DOKS кластера вручную

### 1. Клонируйте репозиторий

```bash
git clone https://github.com/<your-org-or-user>/<your-repo>.git
cd <your-repo>/phase1

### 2. Инициализируйте Terraform

```bash
terraform init

### 3. Примените конфигурацию

```bash
terraform apply -auto-approve

### 4. Экспортируйте kubeconfig

```bash
terraform output -raw kubeconfig_raw > ~/.kube/config
chmod 600 ~/.kube/config

## Фаза 2: Установка Cert-Manager и ClusterIssuer вручную

### Убедитесь, что ~/.kube/config корректно настроен и вы подключены к кластеру перед выполнением этого этапа.
### 1. Запустите скрипт установки

```bash
chmod +x .scripts/deploy.sh
.scripts/deploy.sh

### Зависимости

Убедитесь, что у вас установлены:

Terraform >= v1.0
kubectl
doctl (DigitalOcean CLI)
Аккаунт в DigitalOcean и API токен
