#!/bin/bash

cat << EOF
===================================
- Systemd Issue Fix
  Refer to https://github.com/microsoft/WSL/issues/8843
  This action require one time root permission request
===================================
EOF

sudo sh -c 'echo :WSLInterop:M::MZ::/init:PF > /usr/lib/binfmt.d/WSLInterop.conf; sudo systemctl restart systemd-binfmt'