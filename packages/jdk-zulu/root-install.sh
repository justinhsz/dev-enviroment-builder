#!/bin/bash

cat << EOF
===================================
- Zulu JDK
    - Import Zulu JDK public key
    - Install JDK-11
===================================
EOF

curl -s https://repos.azul.com/azul-repo.key | gpg --dearmor -o /usr/share/keyrings/azul.gpg
echo "deb [signed-by=/usr/share/keyrings/azul.gpg] https://repos.azul.com/zulu/deb stable main" | tee /etc/apt/sources.list.d/zulu.list
apt update
apt install zulu11-jdk -y