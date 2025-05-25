# Руководство по ручному развёртыванию Phase 1

В этом руководстве описано, как вручную выполнить развёртывание инфраструктуры из каталога `phase1` с помощью Terraform.

---

## Шаг 1. Клонирование репозитория

Если у вас ещё нет репозитория с проектом, клонируйте его:

```bash
git clone <URL_ВАШЕГО_РЕПОЗИТОРИЯ>
cd <ИМЯ_РЕПОЗИТОРИЯ>/phase1

## Шаг 2. Инициализация Terraform

Перейдите в директорию phase1 и инициализируйте Terraform:

```bash
terraform init

## Шаг 3. Применение инфраструктуры

Запустите применение конфигурации Terraform:

```bash
terraform apply -auto-approve

##Шаг 4. Экспорт kubeconfig

Для взаимодействия с Kubernetes кластером экспортируйте kubeconfig:

```bash
terraform output -raw kubeconfig_raw > ~/.kube/config
chmod 600 ~/.kube/config

ЛИБО

## Запуск автоматизированного скрипта

```bash
.scripts/deploy.sh

## Примечание: Убедитесь, что у скрипта есть права на выполнение:

```bash
chmod +x deploy_phase1.sh


