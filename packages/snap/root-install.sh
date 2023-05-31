#!/bin/bash
echo "Install Snapd"
apt-get -y install snapd 

echo "Install Credential and secret required packages (Jetbrains Tool required)"
apt-get -y install libsecret-1-0 gnome-keyring 