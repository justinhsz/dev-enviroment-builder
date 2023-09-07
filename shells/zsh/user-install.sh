#!/bin/bash

cat << EOF
===============================================
 Zsh Theme/config framework Suggestion
===============================================
    - zimfw: zsh config framework with speed
      https://zimfw.sh

    - powerlevel10k: zsh theme with speed
      https://github.com/romkatv/powerlevel10k
===============================================
EOF

read -p "Do you want to install zim framework and powerlevel10k? (y/n) " yn

if [[ $yn == "y" ]]; then
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | sudo zsh
  echo "zmodule romkatv/powerlevel10k" >> ~/.zimrc
  zsh -c "zimfw install"
else
  echo "Now setup zsh as your default shell"
  sudo chsh -s $(which zsh) $(whoami)
fi