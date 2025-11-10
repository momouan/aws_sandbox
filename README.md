# aws_sandbox

Production-like AWS lab built with **Infrastructure as Code (IaC)**. **Terraform** provisions the cloud resources, **Ansible** bootstraps the hosts and Kubernetes, and **Helm** manages add-ons and application deployments.  
Default cluster topology: 1 control plane + 2 workers. Node counts are configurable.

---

## 🧭 Overview
This project provides a reproducible AWS environment for experimentation, testing, or training on production-like setups.

---

### 🧱 Stack
- **Terraform** — Infrastructure provisioning (VPC, networking, EC2 instances, security groups, etc.)
- **Ansible** — OS configuration, Kubernetes installation (via kubeadm), and cluster initialization.
- **Helm** — Deployment of Kubernetes add-ons and example workloads.

---

## ⚙️ Prerequisites
- An active AWS account with valid authentication (SSO or credentials).
- CLI tools:
  - Terraform ≥ **1.6**
  - Ansible ≥ **2.15**
  - kubectl
  - Helm ≥ **3.13**
- SSH key configured for the target EC2 instances (defaults to `~/.ssh/sandbox`).
- Network access to AWS APIs.

---

## 🧩 Cluster Topology

| Role            | Default Count | Notes                                         |
|-----------------|----------------|-----------------------------------------------|
| Control plane   | 1              | Deployed via Terraform + Ansible              |
| Worker nodes    | 2              | Scalable using `worker_count` Terraform var   |

Adjust topology by updating the Terraform variable `worker_count`.

---

## 🧾 Configuration

To disable SSH host key checking globally, edit your Ansible configuration:

```bash
sudo nano /etc/ansible/ansible.cfg
```
Add the following:
```ini
[defaults]
host_key_checking = False
```

---

## 🚀 Usage

### 1. Provision the infrastructure
Run Terraform tasks (`init`, `fmt`, `validate`, `apply`) to create the AWS environment:

```bash
make up
```

### 2. Configure and install the Kubernetes cluster
Run all Ansible playbooks to bootstrap the nodes, initialize Kubernetes, and install Helm add-ons:

```bash
make install
```

### 3. Destroy the infrastructure
Tear down everything that Terraform created:

```bash
make nuke
```

---

## 👤 Author
Maintained by **Mouad** — DevOps / SRE experimenting with AWS, Kubernetes, and IaC automation.
