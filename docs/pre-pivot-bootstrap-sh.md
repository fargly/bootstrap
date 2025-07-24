# Pre Pivot 'bootstrap.sh' Script

```bash
#!/usr/bin/env bash

# Install Webi ############################################################# #
#curl https://webi.sh | sh

# Source Environment ####################################################### #
#. ~/.config/envman/PATH.env   ## Using source failed in this environment

# Webi Installs ############################################################ #
#for INSTALL in fd ripgrep bat xsv pathman fzf jq yq nerdfont ;do
#for INSTALL in fd ripgrep bat fzf;do
#    webi $INSTALL
#done

# Add ~/.local/bin Directory
mkdir -p $HOME/.local/bin
mkdir -p $HOME/.local/opt

# 'uv' Install ############################################################# #
curl -LsSf https://astral.sh/uv/install.sh | sh

# Clone 'bootstrap' Repository ############################################# #
# curl https://api.github.com/users/fargly/keys | jq blahblah >> $HOME/.ssh/authorized_keys
(cd $HOME/.local/opt && git clone https://github.com/fargly/bootstrap.git || (cd bootstrap && git pull))

# Run Ansible Bootstrap Playbook ########################################### #
uvx --from ansible-core ansible-playbook $HOME/.local/opt/bootstrap/ansible/bootstrap.yaml 


## EOF
```
