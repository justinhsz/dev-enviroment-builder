#!/bin/bash
echo "Install Micromamba -- a replacement of miniconda"

apt-get -y install bzip2

mkdir -p /opt/micromamba
curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
| tar -xvj -C /opt/micromamba/ bin/micromamba
