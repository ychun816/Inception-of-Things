# Vagrant


## commands

| Command             | Purpose       | Explanation                     |
| ------------------- | ------------- | ------------------------------- |
| `vagrant init`      | Create config | Generates a `Vagrantfile`       |
| `vagrant up`        | Start VM      | Downloads box and boots VM      |
| `vagrant halt`      | Stop VM       | Graceful shutdown               |
| `vagrant destroy`   | Delete VM     | Removes VM completely           |
| `vagrant ssh`       | Access VM     | SSH into the VM                 |
| `vagrant status`    | Check state   | Shows running/stopped           |
| `vagrant reload`    | Restart VM    | Reboots and reloads config      |
| `vagrant provision` | Re-run setup  | Re-applies provisioning scripts |
| `vagrant box list`  | List boxes    | Shows installed base images     |


## (comapred to docker)

| Command               | Purpose          | Explanation                   |
| --------------------- | ---------------- | ----------------------------- |
| `docker build`        | Build image      | Creates image from Dockerfile |
| `docker images`       | List images      | Shows local images            |
| `docker run`          | Run container    | Starts a new container        |
| `docker ps`           | List containers  | Running containers            |
| `docker ps -a`        | All containers   | Including stopped             |
| `docker stop`         | Stop container   | Graceful stop                 |
| `docker rm`           | Remove container | Deletes container             |
| `docker rmi`          | Remove image     | Deletes image                 |
| `docker exec`         | Run command      | Execute inside container      |
| `docker logs`         | View logs        | Container output              |
| `docker-compose up`   | Multi-container  | Start services from config    |
| `docker-compose down` | Stop services    | Tear down stack               |

---

## When to use which?

Below is the **English explanation of the core differences**, using the **same analogy**, written clearly and professionally.

---

## Core Difference (With Analogy)


> **Vagrant builds complete machines.**
> **Docker ships runnable applications.**

### Vagrant


* Manages **virtual machines (VMs)**
* Includes a **full operating system**
  (Linux OS, kernel, system services such as systemd)

#### Analogy: **Building a House**

* Has a foundation (kernel)
* Has plumbing and electricity (system services)
* Has full living space (entire OS)

👉 Inside the house, you can:

* Install any software
* Configure firewalls
* Experiment with networking
* Break the system completely and rebuild it from scratch

#### Typical Real-Life Use Cases

* Learning Linux and system administration
* Simulating real production servers
* Running legacy systems or specific OS versions

---

### Docker

* Manages **containers**
* Shares the **host machine’s kernel**
* Packages only **the application and its dependencies**

#### Real-Life Analogy: **Lunch Boxes**

* One shared kitchen (kernel)
* Each lunch box contains only its own food
* Open it, eat it, throw it away

👉 You only care about:

* Whether the application runs
* That it runs the same everywhere

#### Typical Real-Life Use Cases

* Deploying web applications
* CI/CD pipelines
* Microservices architectures
* Cloud-native environments

---



| Question                        | Use     |
| ------------------------------- | ------- |
| “Do I need a full server?”      | Vagrant |
| “Do I just need my app to run?” | Docker  |
| “Am I managing OS behavior?”    | Vagrant |
| “Am I deploying software?”      | Docker  |

---

## ingress.yaml

- `ingress.yaml` defines an Ingress resource in Kubernetes
- Acts as a smart *router* for HTTP/HTTPS traffic coming into your cluster.

- It receives external requests (from your browser or curl) and routes them to the correct Service based on rules defined (like hostnames or paths).
- For example, it can send requests for app1.com to the App 1 service, app2.com to App 2, and all other requests to App 3.
- Ingress works with an Ingress Controller (like Traefik, which is included by default in K3s) to actually handle and forward the traffic.

> `ingress.yaml` is cluster’s “traffic controller” for web requests, let you expose multiple apps on a single IP and port, with flexible routing rules.

---

## Ruby essentials

[Ruby Basic Syntax](https://www.geeksforgeeks.org/ruby/ruby-basic-syntax/)