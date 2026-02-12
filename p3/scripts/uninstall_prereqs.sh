#!/bin/bash                        

# -------------------------------
# Pastel Color Palette (Truecolor)
# -------------------------------
PINK='\033[38;2;255;179;186m'
MINT='\033[38;2;186;255;201m'
PEACH='\033[38;2;255;223;186m'
LAVENDER='\033[38;2;204;204;255m'
NC='\033[0m'
# -------------------------------

# Check root permission
if [ "$(id -u)" -ne 0 ] && [ -z "$SUDO_UID" ] && [ -z "$SUDO_USER" ]; then
	printf "${PINK}[LINUX]${NC} - Permission denied. Run with sudo.\n"
	exit 87
fi

# Delete each existing cluster
printf "${PEACH}[K3D]${NC} - Deleting K3d clusters...\n"
for cluster in $(k3d cluster list -o json | jq -r '.[].name' 2>/dev/null); do
	k3d cluster delete "$cluster"     #
done

# Remove k3d binary
printf "${PEACH}[K3D]${NC} - Removing K3d...\n"
rm -rf /usr/local/bin/k3d          

# Remove argocd CLI
printf "${LAVENDER}[ARGOCD]${NC} - Removing ArgoCD CLI...\n"
rm -rf /usr/local/bin/argocd       

# Remove kubectl
printf "${LAVENDER}[KUBECTL]${NC} - Removing kubectl...\n"
rm -rf /usr/local/bin/kubectl       

# Remove curl
printf "${MINT}[CURL]${NC} - Removing Curl...\n"
apt-get remove -y curl              

# Remove docker data
printf "${PEACH}[DOCKER]${NC} - Removing Docker...\n"
apt-get remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin
rm -rf /var/lib/docker             
rm -rf /var/lib/containerd

printf "${MINT}[CLEANUP]${NC} - Cleaning up system...\n"
apt-get autoremove -y
apt-get autoclean -y

rm -rf /etc/apt/keyrings/docker.gpg
rm -rf /etc/apt/sources.list.d/docker.list
rm -rf /etc/apt/sources.list.d/kubern
