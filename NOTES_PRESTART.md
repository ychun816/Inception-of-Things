# Pre-Start Notes

from "Infrastructure as Code" (Vagrant) to "GitOps" (ArgoCD).

## 1. Concepts to Learn First

### Virtualization & Networking
*   **Vagrant:** How to configure a `Vagrantfile` to set a static IP (`192.168.56.110`).
*   **Host Resolution:** How your local computer (the Host) talks to the VM. You will need to edit your `/etc/hosts` file so that `app1.com` points to the VM's IP.

### Kubernetes Objects
*   **ReplicaSet/Deployment:** How to run multiple copies of the same app (App 2 needs 3 replicas).
*   **Service:** How to network those apps internally.
*   **Ingress:** The traffic cop. How to route `app1.com` -> Service 1 and `app2.com` -> Service 2.

### Containerizatio
*   **K3d:** How to run a Kubernetes cluster *inside* Docker containers.
*   **DockerHub:** How to tag images (`v1`, `v2`) and push them to a public repository (if you build your own app).

### GitOps
*   **ArgoCD:** The concept of "The Git repository is the source of truth." You don't run `kubectl apply` manually; you push to GitHub, and ArgoCD sees the change and applies it for you.

---

## 2. Project Structure

```bash
├── p1/                         # Part 1: K3s Discovery
│   ├── Vagrantfile             # Defines the VM (IP 192.168.56.110)
│   └── scripts/
│       └── install_k3s.sh      # Installs K3s (server) and configures kubectl
│
├── p2/                         # Part 2: K3s & Ingress
│   ├── Vagrantfile             # (Likely similar to p1, maybe more resources)
│   ├── scripts/
│   │   └── install.sh
│   └── manifests/
│       ├── app1.yaml
│       ├── app2.yaml
│       ├── app3.yaml
│       └── ingress.yaml
│
└── p3/                         # Part 3: K3d & ArgoCD
    ├── install_docker_k3d.sh
    ├── namespaces.yaml
    ├── argocd-install.yaml
    └── application.yaml
```

*Note: For Part 3, also need a separate **GitHub Repository** (online) that contains the actual deployment files for your app, which ArgoCD will watch.*

---

## 3. Walkthru

### Part 2: K3s and The Three Apps
**Goal:** Access 3 apps via browser on a specific IP.

1.  **Vagrant Setup:**
    *   Create a `Vagrantfile` using a box (e.g., `bento/ubuntu-24.04` or similar).
    *   Configure the network to `private_network` with IP `192.168.56.110`.
    *   Set the hostname to `[your_login]S`.
2.  **Install K3s:**
    *   Write a shell script to install K3s.
    *   *Tip:* K3s comes with **Traefik** (an Ingress Controller) enabled by default. Do not disable it; you need it for the routing.
3.  **Deploy Apps:**
    *   Create 3 Deployments. You can use the `traefik/whoami` image for testing (it's a simple web server that prints its ID).
    *   Ensure App 2 has `replicas: 3`.
    *   Expose them using Services (ClusterIP).
4.  **Configure Ingress:**
    *   Write an Ingress resource.
    *   Rule 1: `host: app1.com` -> service: app1
    *   Rule 2: `host: app2.com` -> service: app2
    *   Default Backend: -> service: app3
5.  **Test:**
    *   On your laptop (NOT the VM), edit `/etc/hosts` and add:
        `192.168.56.110 app1.com app2.com`
    *   Open a browser/curl.

### Part 3: K3d and ArgoCD
**Goal:** Automated deployment. You change code on GitHub -> Cluster updates automatically.

1.  **The Install Script:**
    *   Write a shell script that installs **Docker** first, then **K3d**, then **kubectl**, and finally **ArgoCD CLI**.
2.  **The Infrastructure:**
    *   Create a cluster: `k3d cluster create mycluster`.
    *   Create namespaces: `kubectl create ns argocd` and `kubectl create ns dev`.
3.  **Install ArgoCD:**
    *   Apply the official ArgoCD manifest into the `argocd` namespace.
    *   Access the ArgoCD UI (you usually have to port-forward, e.g., `kubectl port-forward svc/argocd-server -n argocd 8080:443`).
4.  **The "Dev" Chain (GitHub):**
    *   Create a public GitHub repo.
    *   Push a file named `deployment.yaml` there (using Wil's image or your own).
    *   Set the image tag to `v1`.
5.  **Connect the Dots:**
    *   Apply an ArgoCD `Application` manifest in your cluster. It tells Argo: "Watch *this* GitHub repo, path `/`, and sync it to the `dev` namespace."
6.  **Evaluation:**
    *   Go to GitHub repo.
    *   Edit `deployment.yaml`: Change image tag from `v1` to `v2`.
    *   Commit changes.
    *   Watch ArgoCD (in the UI or terminal) detect the valid status is "Out of Sync", and automatically update the pod in your cluster to `v2`.
