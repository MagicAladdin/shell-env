# $Id: ~/.profile.d/nvm.sh wandsas 2018/07/24


[[ -d "$HOME/.nvm/nvm.sh" ]] || return

export NVM_DIR=$HOME/.nvm

source $NVM_DIR/nvm.sh

[[ -n "$BASH_VERSION" ]] && [[ -s "$NVM_DIR/bash_completion" ]] \
    && source $NVM_DIR/bash_completion

# vim:fenc=utf-8:ft=sh:
