# $Id: ~/.zshrc wandsas 2018/08/10
#
# Wandsas ~/.zshrc

# {{{ zshrc already loaded?

[[ -n "$zshrc_loaded" ]] && return

# }}}

# {{{ Configure ZSH features

# Empty means loading the feature

# 1. https://github.com/psprint/zsh-morpho
ZSHRC_SKIP_ZMORPHO=

# 2. https://github.com/zdharma/history-search-multi-word
ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD=

# 3. https://github.com/zdharma/fast-syntax-highlighting
ZSHRC_SKIP_FAST_SYNTAX_HIGHLIGHTING=

# 4. https://github.com/zsh-users/zsh-autosuggestions
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

# {{{ Running zshrc hooks

for f ($ZDOTDIR/.zsh/rc.d/*.sh)
    [[ -r "$f" ]] && source $f

unset f

# }}}

# {{{ Init Direnv chdir hooks

eval "$(direnv hook zsh)"

# }}}

# {{{ zshrc loaded

zshrc_loaded=y

debug "$ZDOTDIR/.zshrc loaded"

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
