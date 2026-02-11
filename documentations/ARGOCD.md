# Argo CD

## resources 

- [overview](https://argo-cd.readthedocs.io/en/stable/)
- [What is ArgoCD](https://www.youtube.com/watch?v=p-kAqxuJNik)
- [ArgoCD Tutorial for Beginners | GitOps CD for Kubernetes](https://www.youtube.com/watch?v=MeU5_k9ssrs)


---
- Argo CD works ONLY with Kubernetes.
- Argo CD is a declarative, GitOps-based continuous delivery (CD) tool designed specifically for Kubernetes.
- It automates the deployment of applications to Kubernetes clusters by using a Git repository as the single source of truth.

> If something is defined in Git, Argo CD makes sure your Kubernetes cluster matches it.


> If Kubernetes is: The system that runs containers
> Then Argo CD is: The system that ensures Kubernetes always matches what is written in Git
> And GitOps is: The philosophy that Git controls everything

---

## summary 

| Traditional CD                         | GitOps (Argo CD)             |
| -------------------------------------- | ---------------------------- |
| CI pipeline pushes directly to cluster | Git is updated               |
| CI needs cluster credentials           | Argo CD lives inside cluster |
| Harder to audit                        | Git history = full audit log |
| Manual drift possible                  | Auto drift detection         |
| Imperative                             | Declarative                  |


## CONCEPTS TO STUDY:

[] namespace
[] Kubernetes manifests