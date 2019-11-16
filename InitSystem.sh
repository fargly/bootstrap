#!/usr/bin/env bash



function BootStrap_sudo {
    ## Modify sudo to NOPASSWORD
    echo "%sudo   ALL=(ALL:ALL) NOPASSWD: ALL" > /tmp/sudogroupperms
    sudo chown root:root /tmp/sudogroupperms
    sudo mv /tmp/sudogroupperms /etc/sudoers.d/sudogroupperms
}


##function BootStrap_ansible {
##    ## Install Ansible and Invoke Bootstrap Playbook
##    sudo apt install -y ansible 2>/dev/null
##    ## Invoke Bootstrap Playbook
##}


function BootStrap_vim {
    ## Install Vim and Stub Minimal .vimrc
    sudo apt install -y vim 2>/dev/null
    echo "
filetype off
nnoremap ; :
filetype plugin indent on
set encoding=utf-8
syntax on
colorscheme elflord
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set autoindent
set ruler
set number
set laststatus=2
nnoremap <silent> <C-l> <C-w>w
    " > /home/fargly/.vimrc
    chown fargly:fargly /home/fargly/.vimrc
}


function BootStrap_chezmoi {
    ## Add Support
    sudo apt-get install --assume-yes git curl gnupg pinentry-curses 2>/dev/null
    ## Install
    curl -sfL https://git.io/chezmoi | sh
    ## Initialize
    ~/bin/chezmoi init https://fargly@github.com/fargly/farglyChezmoi.git
    #openssl aes-256-cbc -a -salt > keyring_backup.tgz.aes.stdhash.enc
    ## Hydrate GPG Keyring
    cat .local/share/chezmoi/outputBin/keyring_backup.tgz.aes.stdhash.enc | openssl aes-256-cbc -d -a | (cd ~/ && tar xzf -)

}


################################
## MAIN BLOCK
################################
#BootStrap_ansible
#BootStrap_vim 
#BootStrap_sudo
BootStrap_chezmoi



## EOF
