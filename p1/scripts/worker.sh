#!/bin/bash
# Worker setup script for K3s

SERVER_IP="192.168.56.110"
WORKER_IP="192.168.56.111"
TOKEN_FILE="/vagrant/node-token"

# Update package index and install curl
sudo apt-get update
sudo apt-get install -y curl

echo "Installing K3s on Worker..."

# Wait until server writes the token into shared folder
while [ ! -f $TOKEN_FILE ]; do
    echo "Waiting for server token at $TOKEN_FILE..."
    sleep 5
done

# Read token into variable
TOKEN=$(cat $TOKEN_FILE)

# Download and install K3s in agent mode
curl -sfL https://get.k3s.io | \
K3S_URL=https://$SERVER_IP:6443 \
K3S_TOKEN=$TOKEN \
sh -s - agent \
    --node-ip $WORKER_IP \
    --flannel-iface eth1

echo "Worker joined cluster K3s."
