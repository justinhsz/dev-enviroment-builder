#!/bin/bash

cat << EOF
===================================
- Common Development Tools
    - git
    - jq
===================================
EOF

apt update
apt install -y git jq