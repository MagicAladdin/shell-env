#
# Wandsas ~/.zshrc
#

# {{{ Configure ZSH features

# Empty means disabled and not empty means loading the feature

ZSHRC_SKIP_ZMORPHO=

ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD=

ZSHRC_SKIP_FAST_SYNTAX_HIGHLIGHTING=

ZSHRC_SKIP_AUTOSUGGESTIONS=

ZSHRC_KEEP_FUNCTIONS=

# }}}

# {{{ Infopath

typeset -U infopath
infopath=(
    $HOME/{share/,}info(N)
    /usr/{local/,}share/info/(N)
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

# {{{ Running zsh hooks

for f ($HOME/.zsh/rc.d/*.sh)
    [[ -r "$f" ]] && source $f

unset f

# {{{ Init Direnv chdir hooks

eval "$(direnv hook zsh)"

# }}}

# vim:fenc=utf-8:ft=zsh:ts=4:sts=4:sw=4:et:fdm=marker:foldlevel=0:
