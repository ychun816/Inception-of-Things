#!/bin/bash
# Use bash shell to execute this script

# Read the first argument passed to the script
# Expected values: "server" or "worker"
NODE_TYPE=$1

# Static IP address of the K3s server (controller, agent)
SERVER_IP="192.168.56.110"
WORKER_IP="192.168.56.111"

# Shared file path for the K3s cluster join token
# /vagrant is a shared folder between host and all VMs
TOKEN_FILE="/vagrant/node-token"


# --------------------------------------------------
# Common setup (runs on BOTH server and worker)
# --------------------------------------------------

# Update package index
# Install curl (required to download K3s installer)
sudo apt-get update
sudo apt-get install -y curl


# --------------------------------------------------
# Server node setup
# --------------------------------------------------
if [ "$NODE_TYPE" == "server" ]; then

    echo "Installing K3s on Server..."

    # Download and install K3s in server mode
    # INSTALL_K3S_EXEC allows passing arguments to the K3s service
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


# --------------------------------------------------
# Worker node setup
# --------------------------------------------------
elif [ "$NODE_TYPE" == "worker" ]; then

    echo "Installing K3s on Worker..."

    # Wait until server writes the token into shared folder
    while [ ! -f $TOKEN_FILE ]; do
        echo "Waiting for server token at $TOKEN_FILE..."
        sleep 5
    done

    # Read token into variable
    TOKEN=$(cat $TOKEN_FILE)

    # Download and install K3s in agent mode
    # Join the existing cluster using server URL and token
    curl -sfL https://get.k3s.io | \
    K3S_URL=https://$SERVER_IP:6443 \
    K3S_TOKEN=$TOKEN \
    sh -s - agent \
        --node-ip $WORKER_IP \
        --flannel-iface eth1

    echo "Worker joined cluster K3s."
fi



## NOTES ## 

    # flags:
    # --write-kubeconfig-mode 644
    #   → Allows non-root users to read kubeconfig
    #
    # --node-ip
    #   → Forces Kubernetes to use the private IP
    #
    # --flannel-iface eth1
    #   → Forces pod networking to use Vagrant private network

    # K3S_URL
    #   → Kubernetes API endpoint of the server
    #
    # K3S_TOKEN
    #   → Authentication token to join the cluster
    #
    # agent
    #   → Runs K3s as a worker node only