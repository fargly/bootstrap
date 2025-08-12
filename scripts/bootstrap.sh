#!/usr/bin/env bash

# Minimal Bootstrapping Sequence To Launch Ansible Playbook ################ #

# Add ~/.local/bin Directory ############################################### #
mkdir -p $HOME/.local/bin

# 'uv' Install ############################################################# #
wget -O- https://astral.sh/uv/install.sh | sh

# Run Ansible Bootstrap Playbook ########################################### #
 wget -O- https://raw.githubusercontent.com/fargly/bootstrap/main/playbooks/bootstrap.yaml | \
    $HOME/.local/bin/uvx --from ansible-core ansible-playbook --ask-become-pass /dev/stdin

## EOF
