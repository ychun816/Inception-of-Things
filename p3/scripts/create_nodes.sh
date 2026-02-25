#!/bin/bash
# Create k3d cluster and namespaces, apply app manifest
set -e

MINT='\033[38;2;186;255;201m'
PEACH='\033[38;2;255;223;186m'
NC='\033[0m'

# Create k3d cluster
if ! k3d cluster list | grep -q mycluster; then
  echo -e "${PEACH}Creating k3d cluster...${NC}"
  k3d cluster create mycluster
else
  echo -e "${MINT}k3d cluster already exists.${NC}"
fi

# Create namespaces
kubectl apply -f ../confs/namespaces.yaml

# Deploy application
kubectl apply -f ../confs/app.yaml

echo -e "${MINT}Cluster, namespaces, and app are ready!${NC}"
