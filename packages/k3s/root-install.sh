#!/bin/bash

cat << EOF
===================================
- Local Kubernetes Cluster
    - Install k3s
    - Setup podman local registry
    - Restart k3s
===================================
EOF

curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE='644' sh -

mkdir -p /etc/rancher/k3s

cat <<EOF > /etc/rancher/k3s/registries.yaml
mirrors:
  localhost:
    endpoint:
      - "http://localhost:5000"
EOF

# systemctl restart k3s