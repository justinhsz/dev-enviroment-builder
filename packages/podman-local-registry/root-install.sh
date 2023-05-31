#!/bin/bash

cat << EOF
===================================
- Podman local registry
    - Setup local registry
    - Share registry folder
===================================
EOF

mkdir -p /var/lib/registry

cat <<EOF > /etc/containers/registries.conf.d/localhost.conf
[[registry]]
location = "localhost:5000"
insecure = true
EOF