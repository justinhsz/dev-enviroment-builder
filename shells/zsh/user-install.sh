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
  sudo chsh -s $(which zsh) $(whoami)
  curl -fsSL https://raw.githubusercontent.com/zimfw/install/master/install.zsh | sudo -u $(whoami) zsh
  echo "zmodule romkatv/powerlevel10k" >> ~/.zimrc
  # need to reload
  source ~/.zshrc
  zsh -c "zimfw install"
else
  echo "Now setup zsh as your default shell"
  sudo chsh -s $(which zsh) $(whoami)
fi