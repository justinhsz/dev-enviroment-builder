#!/bin/bash

cat << EOF
===================================
- Common Development Tools (snaps)
    - yq
===================================
EOF

if [ -x "$(command -v snap)" ]; then
  sudo snap install yq
fi