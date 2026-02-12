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

# check if a command exists and install if not
check_install() {
  local name=$1                      # Human-readable name of the software
  local command=$2                   # check if installed
  local install_command=$3           # install the software

  if $command &> /dev/null           # check command silently
  then
    echo -e "${MINT}- $name is installed ${NC}\n"   # Print success if exists
  else
    echo -e "${PEACH}- $name is not installed. Installing...${NC}\n"
    eval $install_command            
    echo -e "${MINT} $name has been successfully installed ${NC}\n"
  fi
}

# check permissions
if [ "$(id -u)" -ne 0 ] && [ -z "$SUDO_UID" ] && [ -z "$SUDO_USER" ]; then
	printf "${PINK}[LINUX]${NC} - Permission denied. Please run the command with sudo privileges.\n"
	exit 87
fi

# Remove K3d Cluster (if exists)
printf "${PEACH}[K3D]${NC} - Deleting K3d cluster (if any)...\n"
for cluster in $(k3d cluster list -o json | jq -r '.[].name' 2>/dev/null); do
	k3d cluster delete "$cluster"
done

# Uninstall K3d
printf "${PEACH}[K3D]${NC} - Removing K3d...\n"
rm -rf /usr/local/bin/k3d

# Uninstall ArgoCD CLI
printf "${LAVENDER}[ARGOCD]${NC} - Removing ArgoCD CLI...\n"
rm -rf /usr/local/bin/argocd

# Uninstall Kubectl
printf "${LAVENDER}[KUBECTL]${NC} - Removing kubectl...\n"
rm -rf /usr/local/bin/kubectl

# Uninstall Curl
printf "${MINT}[CURL]${NC} - Removing Curl...\n"
apt-get remove -y curl

# Uninstall Docker
printf "${PEACH}[DOCKER]${NC} - Removing Docker and related components...\n"
apt-get remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
rm -rf /var/lib/docker
rm -rf /var/lib/containerd

# Clean up remaining files
printf "${MINT}[CLEANUP]${NC} - Cleaning up system...\n"
apt-get autoremove -y
apt-get autoclean -y

# Remove Docker's keyring and repository
rm -rf /etc/apt/keyrings/docker.gpg
rm -rf /etc/apt/sources.list.d/docker.list

# Remove Kubernetes repo (if added)
rm -rf /etc/apt/sources.list.d/kubernetes.list

printf "${MINT}[DONE]${NC} - Everything has been removed. System is clean!\n"
