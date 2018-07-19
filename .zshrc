#
# Wandsas ~/.zshrc
#

# {{{ Configure ZSH features

ZPLUGIN=

ZMORPHO=y

FAST_SYNTAX_HIGHLIGHTING=y

HISTORY_SEARCH_MULTI_WORD=y

ZSH_SYNTAX_HIGHLIGHTING=

AUTO_FU=

ZSH_AUTOSUGGESTIONS=y

# }}}

# {{{ Infopath

typeset -U infopath
infopath=(
    $HOME/{share/,}info(N)
    /usr/{.local/,}share/info/(N)
    $infopath
    )

# }}}

# {{{ Manpath

typeset -U manpath
manpath=(
    $ZDOTDIR/share/man/(N)
    /usr/{,local/,}share/man(N)
    $manpath[@]
    )

# }}}

# {{{ Running hooks

for f ($HOME/.zsh/rc.d/*.sh)
    [[ -r "$f" ]] && source $f

unset f

eval "$(direnv hook zsh)"

# }}}

# vim:fenc=utf-8:ft=zsh:ts=4:sts=4:sw=4:et:fdm=marker:foldlevel=0:

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
