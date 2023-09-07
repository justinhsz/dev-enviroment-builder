#!/bin/bash

cat << EOF
===================================
- Temurin JDK
    - Import Temurin JDK public key
    - Install JDK-11
===================================
EOF

apt install -y wget apt-transport-https

mkdir -p /etc/apt/keyrings
wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | tee /etc/apt/keyrings/adoptium.asc

echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | tee /etc/apt/sources.list.d/adoptium.list

apt update
apt install -y temurin-11-jdk