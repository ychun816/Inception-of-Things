# K3s


## documentations 
- [s3s overview](https://k3s.io/)
- [k3s vs k8s: What's the difference?](https://www.youtube.com/watch?v=FmLna7tHDRc)
- [Kubernetes Explained in 6 Minutes | k8s Architecture](https://www.youtube.com/watch?v=TlHvYWVUZyc)


## k3s vs k8s 

> K3s is Kubernetes optimized for simplicity, speed, and low-resource environments.
> K8s is the full-featured standard, ideal for complex, large-scale production systems.
> Both are real Kubernetes—the difference is scope, defaults, and operational overhead.

| Aspect                          | K3s                                                     | Kubernetes (K8s)                                 |
| ------------------------------- | ------------------------------------------------------- | ------------------------------------------------ |
| **Purpose**                     | Lightweight Kubernetes distribution                     | Full, standard Kubernetes                        |
| **Target Use Case**             | Edge computing, IoT, CI/CD, development, small clusters | Production-grade, large-scale clusters           |
| **Installation**                | Single binary, very simple                              | Multiple components, more complex                |
| **Binary Size**                 | ~50–70 MB                                               | Hundreds of MB (multiple binaries)               |
| **System Requirements**         | Low CPU & memory                                        | Higher CPU & memory                              |
| **Default Datastore**           | SQLite (default), etcd optional                         | etcd (required)                                  |
| **Container Runtime**           | containerd (embedded)                                   | containerd, CRI-O, others                        |
| **Networking (CNI)**            | Flannel (default)                                       | Multiple options (Calico, Flannel, Cilium, etc.) |
| **Ingress Controller**          | Traefik (built-in)                                      | None by default                                  |
| **Load Balancer**               | ServiceLB (built-in)                                    | External solution required                       |
| **High Availability**           | Supported, simplified                                   | Fully supported, more complex                    |
| **Cloud Provider Integrations** | Minimal                                                 | Extensive                                        |
| **Upgrades & Maintenance**      | Easy, automated                                         | More manual and controlled                       |
| **CNCF Conformance**            | Fully CNCF-certified                                    | Fully CNCF-certified                             |
| **Learning Curve**              | Gentle                                                  | Steeper                                          |
| **Typical Users**               | Developers, IoT teams, startups                         | Enterprises, platform teams                      |


![alt text](https://www.fsp-group.com/upload/230221-63F436389ECE4.png)

https://www.ionos.ca/digitalguide/fileadmin/_processed_/b/f/csm_cloud-architecture-layers_08a7bb9dad.webp

https://static.packt-cdn.com/products/9781788832687/graphics/assets/f4247b5b-5d60-4fe1-95ec-c69d5cbb16a7.png


### Real-World Analogy (Very Important for Intuition)
> Docker = package
> Kubernetes = manage many packages at scale
> K3s = Kubernetes, simplified for small or remote locations

| Technology           | Analogy                                                                                            |
| -------------------- | -------------------------------------------------------------------------------------------------- |
| **Docker**           | A **shipping container** that packages one product (an app)                                        |
| **Kubernetes (K8s)** | A **large international port authority** managing thousands of containers, ships, and rules        |
| **K3s**              | A **small, efficient regional port** doing the same job, but optimized for limited space and staff |

### commands 

| Task          | Docker               | K3s                 | K8s          |                         |
| ------------- | -------------------- | ------------------- | ------------ | ----------------------- |
| Install       | `apt install docker` | `curl               | sh`          | kubeadm / cloud tooling |
| Start cluster | N/A                  | Automatic           | Manual setup |                         |
| Cluster type  | Single host          | Lightweight cluster | Full cluster |                         |

### Running Workloads
| Task      | Docker             | K3s / K8s                   |
| --------- | ------------------ | --------------------------- |
| Run app   | `docker run nginx` | `kubectl apply -f pod.yaml` |
| List apps | `docker ps`        | `kubectl get pods`          |
| Logs      | `docker logs`      | `kubectl logs pod`          |
| Delete    | `docker rm`        | `kubectl delete pod`        |

## Docker vs K3s vs K8s

> Docker runs apps
> Kubernetes manages apps
> K3s manages apps where resources are limited

| Aspect              | Docker            | K3s          | Kubernetes   |
| ------------------- | ----------------- | ------------ | ------------ |
| Layer               | Container runtime | Orchestrator | Orchestrator |
| Complexity          | Low               | Medium       | High         |
| Resource usage      | Very low          | Low          | High         |
| Scale               | Single / few      | Small–medium | Large        |
| IoT suitability     | ❌                 | ✅            | ⚠️           |
| Production at scale | ❌                 | ⚠️           | ✅            |
| Learning curve      | Easy              | Moderate     | Steep        |
