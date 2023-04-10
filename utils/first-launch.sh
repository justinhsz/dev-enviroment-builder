#!/bin/bash

export USERNAME=$1

adduser $USERNAME
usermod -aG sudo $USERNAME

cat <<EOF > /etc/wsl.conf

[user]
default = $USERNAME

[boot]
systemd = true

# workaround for issue: https://github.com/conda-forge/podman-feedstock/issues/25
command = mount --make-rshared /

EOF

su - $USERNAME -c /opt/micromamba/bin/micromamba shell init -s bash -p ~/.conda/envs
