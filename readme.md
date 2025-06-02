# Let's Encrypt Automation on DigitalOcean Kubernetes (DOKS)

This project automates SSL/TLS certificate management using Let's Encrypt and Cert-Manager on a Kubernetes cluster deployed on DigitalOcean using Terraform, Helm, GitHub Actions, and Argo CD.

## 📦 Project Structure

```
lets_encrypt_pet/
├── terraform/
│   ├── phase1/                # Manual: creates the Kubernetes cluster (DOKS)
│   ├── phase2/                # Automated via GitHub Actions
│   │   ├── main.tf            # Cert-Manager, ClusterIssuer, nginx-ingress
│   │   ├── cluster_issuer.tf
│   │   └── demo-app/          # App with TLS via cert-manager
│   └── demo-app.yaml          # Argo CD Application definition
├── argocd/
│   ├── cluster-bootstrap.yaml
│   ├── cluster-issuer.yaml
│   └── demo-app.yaml
├── .github/
│   └── workflows/
│       └── deploy.yml         # GitHub Actions automation
└── README.md
```

---

## 🛠️ Phase 1: Manual Kubernetes Cluster Setup

1. **Initialize Terraform**:

   ```bash
   cd terraform/phase1
   terraform init
   ```
2. **Apply Infrastructure**:

   ```bash
   terraform apply -auto-approve
   ```

This creates a DOKS cluster and outputs the `kubeconfig` for further use.

---

## ⚙️ Phase 2: Automated Deployment via GitHub Actions

Everything from Phase 2 onward is fully automated on GitHub Actions:

### What it does:

* Installs `cert-manager` via Helm.
* Installs `nginx-ingress` with DigitalOcean LoadBalancer support.
* Creates a Let's Encrypt `ClusterIssuer`.
* Syncs demo app (Ingress + TLS) via Argo CD.

### Requirements:

Ensure these GitHub secrets are set:

* `DO_TOKEN` – DigitalOcean Personal Access Token
* `CLUSTER_NAME` – Your DOKS cluster name
* `DO_REGION` – DigitalOcean region
* `LETSENCRYPT_EMAIL` – Email for Let's Encrypt ACME account
* `TFC_TOKEN` – Terraform Cloud token
* `ARGOCD_SERVER` – Argo CD API server address
* `ARGOCD_AUTH_TOKEN` – Argo CD API token

---

## 🚀 Deployment Process

1. Make sure Phase 1 has completed and kubeconfig is active.
2. Push any changes to `terraform/phase2/` or `demo-app/`, and GitHub Actions will:

   * Connect to the cluster
   * Apply Helm releases (cert-manager, nginx-ingress)
   * Apply `ClusterIssuer`
   * Sync the demo app using Argo CD

---

## 🌐 DNS Configuration

Make sure your domain `demo.example.com` points to the public IP of your `nginx-ingress` LoadBalancer:

```bash
kubectl get svc -n ingress-nginx
```

Update DNS A record:

```
demo.example.com → <LoadBalancer IP>
```

---

## ✅ Validation

You can validate that everything works by visiting:

```
https://demo.example.com
```

The certificate should be issued by Let's Encrypt.

Check certificate status:

```bash
kubectl get certificate -n demo-app
```

---

## 📎 Related Tools

* [Terraform](https://www.terraform.io/)
* [Cert-Manager](https://cert-manager.io/)
* [Let's Encrypt](https://letsencrypt.org/)
* [Argo CD](https://argo-cd.readthedocs.io/)
* [DigitalOcean Kubernetes](https://www.digitalocean.com/products/kubernetes)

---

## 🧹 Cleanup

To destroy the cluster (manual step):

```bash
cd terraform/phase1
terraform destroy
```

---

## 🙋 Need Help?

Create an issue or open a PR in the [GitHub repo](https://github.com/Flaxeny/lets_encrypt_pet).

