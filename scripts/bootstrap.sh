#!/usr/bin/env bash

# Install Webi ############################################################# #
curl https://webi.sh | sh

# Source Environment ####################################################### #
source ~/.config/envman/PATH.env

# Webi Installs ############################################################ #
for INSTALL in fd ripgrep bat xsv pathman fzf jq yq nerdfont ;do
    webi $INSTALL
done

# 'uv' Install ############################################################# #
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone 'bootstrap' Repository ############################################# #
(cd $HOME/.local/opt && git clone https://github.com/fargly/bootstrap.git)

# Run Ansible Bootstrap Playbook ########################################### #
uvx --from ansible-core ansible-playbook --help


## EOF


