#!/usr/bin/env bash

# Install Webi ############################################################# #
curl https://webi.sh | sh

# Source Environment ####################################################### #
source ~/.config/envman/PATH.env

# Webi Installs ############################################################ #
for INSTALL in fd ripgrep bat xsv pathman fzf jq yq nerdfonts ;do
    webi $INSTALL
done

# 'uv' Install ############################################################# #
curl -LsSf https://astral.sh/uv/install.sh | sh



## EOF


