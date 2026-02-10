# Pre-Start Notes

from "Infrastructure as Code" (Vagrant) to "GitOps" (ArgoCD).

## Concepts to Learn First

### Virtualization & Networking
*   **Vagrant:** How to configure a `Vagrantfile` to set a static IP (`192.168.56.110`).
*   **Host Resolution:** How your local computer (the Host) talks to the VM. You will need to edit your `/etc/hosts` file so that `app1.com` points to the VM's IP.

### Kubernetes Objects
*   **ReplicaSet/Deployment:** How to run multiple copies of the same app (App 2 needs 3 replicas).
*   **Service:** How to network those apps internally.
*   **Ingress:** The traffic cop. How to route `app1.com` -> Service 1 and `app2.com` -> Service 2.

### Containerization
*   **K3d:** How to run a Kubernetes cluster *inside* Docker containers.
*   **DockerHub:** How to tag images (`v1`, `v2`) and push them to a public repository (if you build your own app).

### GitOps
*   **ArgoCD:** The concept of "The Git repository is the source of truth." You don't run `kubectl apply` manually; you push to GitHub, and ArgoCD sees the change and applies it for you.

---

## Learning resources

### Vagrant
- (intro)[https://developer.hashicorp.com/vagrant/intro] 
- (documentation)[https://developer.hashicorp.com/vagrant/docs]
- (beginner tuto)[https://www.youtube.com/watch?v=czMCO1w-xQU&list=PLhW3qG5bs-L9S272lwi9encQOL9nMOnRa]

- Difference between docker and vagrant (VMs vs. Containers)
https://www.simform.com/blog/vms-vs-containers/

### Kubernetes

- (overview)[https://kubernetes.io/docs/concepts/overview/]
- (documentation)[https://kubernetes.io/docs/home/]
- (official tutorial)[https://kubernetes.io/docs/tutorials/]


https://www.youtube.com/watch?v=PziYflu8cB8
https://www.youtube.com/watch?v=PziYflu8cB8
https://www.youtube.com/watch?v=VnvRFRk_51k&pp=ygUSd2hhdCBpcyBrdWJlcm5ldGVz
https://www.youtube.com/watch?v=cC46cg5FFAM

