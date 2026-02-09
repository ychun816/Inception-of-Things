#!/bin/bash

# Update system
sudo apt-get update
sudo apt-get install -y curl

# Install K3s
# --write-kubeconfig-mode 644 allows non-root users to read the kubeconfig
# --node-ip ensures the node uses the correct IP for the cluster
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode 644 --node-ip 192.168.56.110" sh -

# Wait for K3s to be up
echo "Waiting for K3s to be ready..."
sleep 20

# Check status
sudo k3s kubectl get nodes
