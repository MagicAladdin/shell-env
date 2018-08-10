# $Id: ~/.profile.d/node.sh wandsas 2018/07/24
#
# Node.js
#

[[ -d "$HOME/.npm-global" ]] || return

export npm_config_prefix=$HOME/.npm-global

pathmunge $HOME/.npm-global/bin

# vim:fenc=utf-8:ft=sh:
