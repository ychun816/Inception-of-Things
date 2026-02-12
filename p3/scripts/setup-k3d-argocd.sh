#!/bin/bash                         

# -------------------------------
# COLOR SETTING
# -------------------------------
PINK='\033[38;2;255;179;186m'
MINT='\033[38;2;186;255;201m'
PEACH='\033[38;2;255;223;186m'
LAVENDER='\033[38;2;204;204;255m'
NC='\033[0m'
# -------------------------------

set -e                              # Exit immediately if any command fails

ARGOCD_NAMESPACE="argocd"           # Namespace for Argo CD
APP_NAMESPACE="dev"                 # Namespace for application
GITHUB_REPO="git@github.com:ychun816/Inception-of-Things.git"
GITHUB_SSH_KEY_PATH="$HOME/.ssh/id_rsa"

echo -e "${MINT}[LOG] Creating K3d cluster...${NC}\n"
k3d cluster create $USERNAME        # Create local Kubernetes cluster in Docker

echo -e "${MINT}[LOG] Creating namespaces...${NC}\n"
kubectl create namespace $ARGOCD_NAMESPACE
kubectl create namespace $APP_NAMESPACE

# Apply official Argo CD installation manifest
echo -e "${MINT}[LOG] Install ArgoCD...${NC}\n"
kubectl apply -n $ARGOCD_NAMESPACE -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait until ArgoCD server deployment becomes available
echo -e "${PEACH}[LOG] Waiting for ArgoCD to be ready...${NC}\n"
kubectl wait --for=condition=available --timeout=120s deployment/argocd-server -n $ARGOCD_NAMESPACE

# Forward local port 8080 to ArgoCD service
echo -e "${LAVENDER}[LOG] Exposing ArgoCD with port-forward...${NC}\n"
kubectl port-forward svc/argocd-server -n "$ARGOCD_NAMESPACE" 8080:443 > /dev/null 2>&1 &

# Extract admin password from Kubernetes secret
echo -e "${MINT}[LOG] Retrieve ArgoCD password...${NC}\n"
ARGO_PASSWORD=$(kubectl get secret argocd-initial-admin-secret -n $ARGOCD_NAMESPACE -o jsonpath="{.data.password}" | base64 --decode)

# Login using CLI
echo -e "${MINT}[LOG] Logging into ArgoCD...${NC}\n"
argocd login localhost:8080 --username admin --password $ARGO_PASSWORD --insecure

# Register Git repository to Argo CD
echo -e "${LAVENDER}[LOG] Adding Github repo to ArgoCD...${NC}\n"
argocd repo add $GITHUB_REPO --ssh-private-key-path $GITHUB_SSH_KEY_PATH

# Create Argo CD Application resource
echo -e "${MINT}[LOG] Applying ArgoCD application...${NC}\n"
kubectl apply -f "./confs/app.yaml"

sleep 10                            # Wait for sync

kubectl get pods -n $APP_NAMESPACE  # Show deployed pods

echo -e "${PINK}Setup complete!${NC} Access ArgoCD at: http://localhost:8080\n"
echo -e "${PINK}Login with:${NC} admin | $ARGO_PASSWORD\n"

# Forward app service to local port 8888
kubectl port-forward service/tsuchen-app-service -n "$APP_NAMESPACE" 8888:80 > /dev/null 2>&1 &