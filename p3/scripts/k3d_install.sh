#!/bin/bash
# Install Docker, k3d, kubectl, and jq
set -e

# Colors
MINT='\033[38;2;186;255;201m'
PEACH='\033[38;2;255;223;186m'
NC='\033[0m'

# Install Docker
if ! command -v docker &> /dev/null; then
  echo -e "${PEACH}Installing Docker...${NC}"
  curl -fsSL https://get.docker.com | bash
else
  echo -e "${MINT}Docker already installed.${NC}"
fi

# Install k3d
if ! command -v k3d &> /dev/null; then
  echo -e "${PEACH}Installing k3d...${NC}"
  curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
  echo -e "${MINT}k3d already installed.${NC}"
fi

# Install kubectl
if ! command -v kubectl &> /dev/null; then
  echo -e "${PEACH}Installing kubectl...${NC}"
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  chmod +x kubectl
  mv kubectl /usr/local/bin/
else
  echo -e "${MINT}kubectl already installed.${NC}"
fi

# Install jq
if ! command -v jq &> /dev/null; then
  echo -e "${PEACH}Installing jq...${NC}"
  apt-get update && apt-get install -y jq
else
  echo -e "${MINT}jq already installed.${NC}"
fi

echo -e "${MINT}All prerequisites installed!${NC}"
