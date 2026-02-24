# Check List

## Part 1: K3s and Vagrant
**Objective**: Set up a K3s cluster with 1 Controller and 1 Worker using Vagrant.

- [x] **Vagrant Setup**
  - [x] Create `p1/` folder and `Vagrantfile`.
  - [x] **VM 1 (Server):**
    - [x] Hostname: `[login]S` (e.g., `wilS`).
    - [x] IP: `192.168.56.110`.
    - [x] Resources: 1 CPU, 512MB RAM.
  - [x] **VM 2 (Worker):**
    - [x] Hostname: `[login]SW` (e.g., `wilSW`).
    - [x] IP: `192.168.56.111`.
    - [x] Resources: 1 CPU, 512MB RAM.
  - [x] **SSH**: Ensure passwordless SSH works between host and VMs (Vagrant default).

- [x] **K3s Installation**
  - [x] **Server Node (`[login]S`):**
    - [x] Install K3s in `server` (controller) mode.
    - [x] Verify `kubectl` is installed and functioning.
    - [x] Retrieve node token (`/var/lib/rancher/k3s/server/node-token`).
  - [x] **Worker Node (`[login]SW`):**
    - [x] Install K3s in `agent` mode.
    - [x] Join the cluster using the server's IP and token.
  - [x] **Verification**: `kubectl get nodes -o wide` should show both nodes as `Ready`.

  - [ ] **Worker Node (`[login]SW`):**
    - [ ] Install K3s in `agent` mode.
    - [ ] Connect to Server IP `192.168.56.110` using the token.
    
  - [ ] **Verification**: Run `kubectl get nodes` on Server to see both nodes ready.

---

## Part 2: K3s and Three Simple Applications
**Objective**: Deploy 3 web apps and route traffic using Ingress on a single K3s node.

- [x] **Vagrant Setup**
  - [x] Create `p2/` folder and `Vagrantfile`.
  - [x] **VM (Server):**
    - [x] Hostname: `[login]S`.
    - [x] IP: `192.168.56.110`.
    - [x] Install K3s in `server` mode (Traefik enabled by default).

- [x] **Applications**
  - [x] Develop/Select a simple web app image (or use `traefik/whoami` / `wil42/playground`).
  - [x] **App 1**: Deployment + Service (ClusterIP).
  - [x] **App 2**: Deployment (**3 Replicas**) + Service (ClusterIP).
  - [x] **App 3**: Deployment + Service (ClusterIP).

- [x] **Ingress Configuration**
  - [x] Create `ingress.yaml` resource.
  - [x] **Route 1**: Host `app1.com` → directs to App 1.
  - [x] **Route 2**: Host `app2.com` → directs to App 2.
  - [x] **Route 3**: Host `app3.com` → directs to App 3.
  - [x] **Default Route**: Any other host/IP → directs to App 3.

- [] **Testing**
  - [] Configure local `/etc/hosts` to point `app1.com`, `app2.com`, and `app3.com` to `192.168.56.110`.
  - [] Verify access in browser/curl for all 3 scenarios.

---

## Part 3: K3d and Argo CD

**Objective**: Continuous Deployment using K3d and Argo CD.

- [ ] **Preparation & Installation**
  - [x] Write and run a script to install:
    - [x] Docker (if not present)
    - [x] k3d CLI
    - [x] kubectl CLI
    - [x] argocd CLI

- [ ] **Cluster & Namespace Setup**
  - [x] Create K3d cluster (`k3d cluster create`)
  - [x] Create namespaces:
    - [x] argocd
    - [x] dev

- [ ] **Argo CD Installation & Access**
  - [x] Install Argo CD in argocd namespace
  - [x] Port-forward or expose Argo CD UI
  - [x] Retrieve or change default admin password

- [ ] **GitHub Repository & App Deployment**
  - [x] Create a public GitHub repository (name must contain your login)
  - [x] Push deployment manifests (Deployment + Service) for your app
  - [x] Ensure image tag is set to v1 in manifest

- [ ] **Argo CD Application Setup**
  - [x] Create Argo CD Application pointing to your GitHub repo
  - [x] Set target namespace to dev
  - [ ] Sync application and verify pod is running v1
    - [ ] `kubectl get pods -n dev`
    - [ ] `curl http://localhost:8888/` (should return v1)

- [ ] **CI/CD Test: Automatic Update**
  - [x] Change image tag to v2 in GitHub repo
  - [x] Commit and push the change
  - [ ] Wait for Argo CD to sync and update the pod
  - [ ] Verify pod is running v2
    - [ ] `kubectl get pods -n dev`
    - [ ] `curl http://localhost:8888/` (should return v2)

--

## Run test

### P1

1. Start both Vagrant machines:
```bash
vagrant up
```

2. SSH into the Server machine and check K3s status:
```bash
vagrant ssh server
sudo kubectl get nodes
# should see both nodes (server and serverworker) listed
```

3. SSH into the ServerWorker machine and check K3s status:
```bash
vagrant ssh serverworker
sudo kubectl get nodes
# You should see the same node list
```

4. Exit SSH sessions after each check with exit

> If both nodes appear and are Ready, setup is correct

---

### P2

1. Start the Vagrant VM for p2
```bash
cd /sgoinfre/goinfre/Perso/yilin/IoT_me/p2
vagrant up
```

2 SSH into the VM:
```bash
vagrant ssh server
```

3. Check that all three apps are deployed and running:
```bash
kubectl get pods
kubectl get services
kubectl get ingress
```

4. On your local machine, update your /etc/hosts file to map:
```bash
192.168.56.110 app1.com
192.168.56.110 app2.com
192.168.56.110 app3.com
```

5. Test access to each app:
```bash
curl -H "Host: app1.com" http://192.168.56.110
curl -H "Host: app2.com" http://192.168.56.110
curl -H "Host: app3.com" http://192.168.56.110
curl -H "Host: random.com" http://192.168.56.110
```

> Confirm that:
```bash
app1.com returns app1
app2.com returns app2 (with 3 replicas)
app3.com returns app3 (default route)
random.com returns app3 (default route)
```

---

### p3

1. Run script to install Docker, k3d, kubectl, argocd

2. Create K3d cluster
```bash
k3d cluster create
```

3. Create namespaces
```bash
kubectl create namespace argocd
kubectl create namespace dev
```

4. Install ArgoCD in the argocd namespace (follow official docs or script)
5. Access ArgoCD UI (port-forward or loadbalancer) and retrieve/change the admin password
6. Push deployment manifests (with image tag v1) to public GitHub repo
7. Configure ArgoCD Application to watch GitHub repo and target the dev namespace
8. Verify the app is deployed
```bash
kubectl get pods -n dev
curl http://localhost:8888/
```
> Should return v1

9. Change the image tag in GitHub repo to v2, commit, and push
10. Wait for Argo CD to sync and update the pod automatically
11. Verify the update
```bash
kubectl get pods -n dev
curl http://localhost:8888/
```
> Should return v2

---


## other debugging commands
```bash
df -h

```