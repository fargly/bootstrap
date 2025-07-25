#!/usr/bin/env bash

# Minimal Bootstrapping Sequence To Launch Ansible Playbook ################ #

# Add ~/.local/bin Directory ############################################### #
mkdir -p $HOME/.local/bin

# 'uv' Install ############################################################# #
curl -LsSf https://astral.sh/uv/install.sh | sh
. $HOME/.bashrc

# Clone 'bootstrap' Repository ############################################# #
# curl https://api.github.com/users/fargly/keys | jq blahblah >> $HOME/.ssh/authorized_keys
#(cd $HOME/.local/opt && git clone https://github.com/fargly/bootstrap.git || (cd bootstrap && git pull))

# Run Ansible Bootstrap Playbook ########################################### #
#uvx --from ansible-core ansible-playbook $HOME/.local/opt/bootstrap/ansible/bootstrap.yaml 
# uvx --from ansible-core ansible-playbook https://raw.githubusercontent.com/fargly/bootstrap/main/ansible/bootstrap.yaml 
curl https://raw.githubusercontent.com/fargly/bootstrap/main/playbooks/bootstrap.yaml | \
    uvx --from ansible-core ansible-playbook --ask-become-pass /dev/stdin


## EOF
