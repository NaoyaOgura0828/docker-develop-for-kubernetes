#!/bin/bash

# EnvironmentVariable
KUBECTL_VERSION=$KUBECTL_VERSION

# Add Kubernetes to the repository
cat << EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v${KUBECTL_VERSION}/rpm/repodata/repomd.xml.key
EOF

# Install kubectl
sudo dnf install kubectl -y

exit 0
