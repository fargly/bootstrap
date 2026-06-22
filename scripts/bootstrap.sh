#!/usr/bin/env bash

# Minimal Bootstrapping Sequence To Launch Ansible Playbook ################ #

# --------- Manage Current Stable Ansible Breakage for sudo-rs on Ubuntu 26.04 and Others -------- #
which sudo.ws 2>/dev/null >/dev/null && export ANSIBLE_BECOME_EXE=sudo.ws


# Add ~/.local/bin Directory ############################################### #
mkdir -p $HOME/.local/bin

# 'uv' Install ############################################################# #
wget -O- https://astral.sh/uv/install.sh | sh

# 'sudo' Install ########################################################### #
sudo apt install -y sudo
sudo update-alternatives --set sudo /usr/bin/sudo.ws

# Run Ansible Bootstrap Playbook ########################################### #
 wget -O- https://raw.githubusercontent.com/fargly/bootstrap/main/playbooks/bootstrap.yaml | \
    $HOME/.local/bin/uvx --from ansible-core ansible-playbook --ask-become-pass /dev/stdin

## EOF
