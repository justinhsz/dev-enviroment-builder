#!/bin/bash
mkdir -p ~/.conda/envs

echo "Initial mamba to current shell"
export USER_DEFAULT_SHELL=$(basename "$(getent passwd $(whoami) | awk -F: '{print $NF}')")
/opt/micromamba/bin/micromamba shell init -s $USER_DEFAULT_SHELL -p ~/.conda/envs

# echo "Make conda as micromamba alias name"
# echo "alias conda=micromamba" >> ~/.${USER_DEFAULT_SHELL}rc