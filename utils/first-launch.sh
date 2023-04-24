#!/bin/bash

export USERNAME=$1

cat << EOF
===================================
- Create User: $USERNAME
    - Create user
    - Update default login user
===================================
EOF

adduser $USERNAME
usermod -aG sudo $USERNAME

cat <<EOF >> /etc/wsl.conf

[user]
default = $USERNAME

EOF

cat << EOF
===================================
- Python Virtual Environment
    - Setup micromamba
    - Make it more conda-like
===================================
EOF

su -l -c "/opt/micromamba/bin/micromamba shell init -s bash -p ~/.conda/envs" $USERNAME

cat << EOF
===================================
- Podman
    - Setup local registry
    - Setup socket (DOCKER)
===================================
EOF

su -l -c "podman run -d -p 5000:5000 --restart=always --name registry registry:latest" $USERNAME

cat <<EOF > /etc/containers/registries.conf.d/localhost.conf
[[registry]]
location = "localhost:5000"
insecure = true
EOF

su -l -c "systemctl --user enable --now podman.socket" $USERNAME

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

systemctl restart k3s

cat << EOF
===================================
- Bash Settings
    - Append additional settings
===================================
EOF

cat ./dot-files/.bashrc >> /home/$USERNAME/.bashrc