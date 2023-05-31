#!/bin/bash

echo "Install neovim -- a replacement of vi/vim"
deb=$(curl -w "%{filename_effective}" -LO https://github.com/neovim/neovim/releases/download/v0.8.3/nvim-linux64.deb)
dpkg -i $deb && rm $deb && unset deb

echo "Make neovim as default vim/vi tool"
ln -s /usr/bin/nvim /usr/local/bin/vim
ln -s /usr/bin/nvim /usr/local/bin/vi

echo "Install ripgrep to have better experiance on neovim"
apt-get -y install ripgrep