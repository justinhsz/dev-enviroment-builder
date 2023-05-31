#!/bin/bash

export USERNAME=$(echo $1 | tr [:upper:] [:lower:])

cat << EOF
===================================
- Create User: $USERNAME
    - Create user
    - Update default login user
===================================
EOF

adduser $USERNAME
usermod -aG sudo $USERNAME

crudini --set /etc/wsl.conf user default $USERNAME

cat << EOF
===================================
- Setup .wslconfig .wslgconfig
    - Initial /mnt/c/Users/$1/.wslconfig
    - Initial /mnt/c/Users/$1/.wslgconfig
    - Merge files
===================================
EOF

touch /mnt/c/Users/$1/.wslconfig
crudini --merge --output=/mnt/c/Users/$1/.wslconfig /mnt/c/Users/$1/.wslconfig < /opt/wsl/.wslconfig

touch /mnt/c/Users/$1/.wslgconfig
crudini --merge --output=/mnt/c/Users/$1/.wslgconfig /mnt/c/Users/$1/.wslgconfig < /opt/wsl/.wslgconfig