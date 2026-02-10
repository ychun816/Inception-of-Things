# Inception of Things

## Project Structure

```bash
├── p1/                         # Part 1: K3s & Vagrant (2 VMs)
│   ├── Vagrantfile             # Defines 2 VMs (Server + Worker)
│   └── scripts/
│       └── install_k3s.sh      # Installation logic
│
├── p2/                         # Part 2: K3s & Ingress (1 VM)
│   ├── Vagrantfile             # Defines 1 VM (Server)
│   └── manifests/
│       ├── app1.yml
│       ├── app2.yml
│       ├── app3.yml
│       └── ingress.yml
│
└── p3/                         # Part 3: K3d & ArgoCD (Local/VM Script)
    ├── install.sh              # Installs Docker, K3d, ArgoCD CLI
    ├── setup.sh                # Creates cluster, namespaces, apps
    └── config/                 # Manifests for ArgoCD
```

*Note: For Part 3, also need a separate **GitHub Repository** (online) that contains the actual deployment files for your app, which ArgoCD will watch.*

---

## Checklist

### Part 1: K3s and Vagrant
**Objective**: Set up a K3s cluster with 1 Controller and 1 Worker using Vagrant.

- [ ] **Vagrant Setup**
  - [ ] Create `p1/` folder and `Vagrantfile`.
  - [ ] **VM 1 (Server):**
    - [ ] Hostname: `[login]S` (e.g., `wilS`).
    - [ ] IP: `192.168.56.110`.
    - [ ] Resources: 1 CPU, 512MB RAM.
  - [ ] **VM 2 (Worker):**
    - [ ] Hostname: `[login]SW` (e.g., `wilSW`).
    - [ ] IP: `192.168.56.111`.
    - [ ] Resources: 1 CPU, 512MB RAM.
  - [ ] **SSH**: Ensure passwordless SSH works between host and VMs (Vagrant default).

- [ ] **K3s Installation**
  - [ ] **Server Node (`[login]S`):**
    - [ ] Install K3s in `server` (controller) mode.
    - [ ] Verify `kubectl` is installed and functioning.
    - [ ] Retrieve node token (`/var/lib/rancher/k3s/server/node-token`).
  - [ ] **Worker Node (`[login]SW`):**
    - [ ] Install K3s in `agent` mode.
    - [ ] Connect to Server IP `192.168.56.110` using the token.
  - [ ] **Verification**: Run `kubectl get nodes` on Server to see both nodes ready.

---

### Part 2: K3s and Three Simple Applications
**Objective**: Deploy 3 web apps and route traffic using Ingress on a single K3s node.

- [ ] **Vagrant Setup**
  - [ ] Create `p2/` folder and `Vagrantfile`.
  - [ ] **VM (Server):**
    - [ ] Hostname: `[login]S`.
    - [ ] IP: `192.168.56.110`.
    - [ ] Install K3s in `server` mode (Traefik enabled by default).

- [ ] **Applications**
  - [ ] Develop/Select a simple web app image (or use `traefik/whoami` / `wil42/playground`).
  - [ ] **App 1**: Deployment + Service (ClusterIP).
  - [ ] **App 2**: Deployment (**3 Replicas**) + Service (ClusterIP).
  - [ ] **App 3**: Deployment + Service (ClusterIP).

- [ ] **Ingress Configuration**
  - [ ] Create `ingress.yaml` resource.
  - [ ] **Route 1**: Host `app1.com` → directs to App 1.
  - [ ] **Route 2**: Host `app2.com` → directs to App 2.
  - [ ] **Default Route**: Any other host/IP → directs to App 3.

- [ ] **Testing**
  - [ ] Configure local `/etc/hosts` to point `app1.com` and `app2.com` to `192.168.56.110`.
  - [ ] Verify access in browser/curl for all 3 scenarios.

---

### Part 3: K3d and Argo CD
**Objective**: Continuous Deployment using K3d and Argo CD.

- [ ] **Preparation Script**
  - [ ] Write a script to install:
    - [ ] Docker (if not present).
    - [ ] `k3d` CLI.
    - [ ] `kubectl` CLI.
    - [ ] `argocd` CLI.

- [ ] **Infrastructure Setup**
  - [ ] Create K3d cluster: `k3d cluster create`.
  - [ ] Create Namespaces:
    - [ ] `argocd`
    - [ ] `dev`

- [ ] **Argo CD Setup**
  - [ ] Install Argo CD in `argocd` namespace.
  - [ ] Access Argo CD UI (port-forward or loadbalancer).
  - [ ] Change/Retrieve default admin password.

- [ ] **Git Repository (Dev Chain)**
  - [ ] Create a **Public GitHub Repository**.
  - [ ] Name must contain login (e.g., `wil-iot-project`).
  - [ ] Push deployment manifests (Deployment + Service) for your app.
  - [ ] Define Version 1 (`v1`) tag for the image in the manifest.

- [ ] **CI/CD Pipeline**
  - [ ] Configure Argo CD Application watching your GitHub repo.
  - [ ] Target Namespace: `dev`.
  - [ ] **Test Update**:
    - [ ] Change image tag to `v2` in GitHub repo.
    - [ ] Commit & Push.
    - [ ] Verify Argo CD syncs and updates the pod in the cluster automatically.

