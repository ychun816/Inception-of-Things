#!/bin/bash
# Server setup script for K3s

SERVER_IP="192.168.56.110"
TOKEN_FILE="/vagrant/node-token"

# Update package index and install curl
sudo apt-get update
sudo apt-get install -y curl

echo "Installing K3s on Server..."

# Download and install K3s in server mode
curl -sfL https://get.k3s.io | \
INSTALL_K3S_EXEC="server \
    --write-kubeconfig-mode 644 \
    --node-ip $SERVER_IP \
    --flannel-iface eth1" sh -

echo "Waiting for node-token..."

# Wait until K3s generates the cluster join token
while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
    sleep 2
done

# Copy the token to shared folder so workers can read it
cat /var/lib/rancher/k3s/server/node-token > $TOKEN_FILE

echo "Token saved to $TOKEN_FILE"
