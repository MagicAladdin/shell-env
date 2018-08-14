# $Id: ~/.zshrc wandsas 2018/08/10
#
# Wandsas ~/.zshrc

# Allow disabling of entire environment suite
[[ -n "$INHERIT_ENV" ]] && return

sh_load_status .zshrc

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

# {{{ Profiling

[[ -n "$ZSH_PROFILE_RC" ]] && zmodload zsh/zprof

# }}}

# {{{ Options

sh_load_status 'setting options'

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

# {{{ Miscellaneous

sh_load_status 'miscellaneous'

# {{{ ls colours

(( $+commands[dircolors] )) && () {
    if [[ -r "~/.dir_colors" ]] {
        eval $(dircolors -b ~/.dir_colors)
    } elif [[ -r "/etc/DIR_COLORS" ]] {
        eval $(dircolors -b /etc/DIR_COLORS)
    } else { eval $(dircolors) }
}

autoload -U is-at-least

is-at-least 3.1.5 && () {
    zmodload -i zsh/complist

    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#)*=00=01:32'
    # completion colours
    zstyle ':completion:*' list-colors $LS_COLORS
}

# Is GNU ls available?
if ls --color=auto / >/dev/null 2>&1; then
  alias ls='command ls --color=auto'
elif ls -G / >/dev/null 2>&1; then
  alias ls='command ls -G'
fi
alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'

# }}}

# {{{ grep colors

if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
  alias  grep='command grep  --color=auto'
  alias egrep='command egrep --color=auto'
  alias ngrep='command ngrep --color=auto'
  alias zgrep='command zgrep --color=auto'
fi

# }}}

# {{{ less colors

(( ${terminfo[colors]:-0} >= 8 )) && () {
  export LESS_TERMCAP_mb=$'\E[1;31m'
  export LESS_TERMCAP_md=$'\E[1;38;5;74m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[1;3;5;246m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[1;32m'
}

# }}}

# {{{ Don't always autlogout

unset TMOUT

# }}}

# }}}

# {{{ Running local hooks

sh_load_status 'local hooks'
run_hooks .zsh/rc.d

# }}}

# {{{ Profiling report

if [[ -n "$ZSHRC_PROFILE_RC" ]]; then
    zprof >! ~/zshrc.zprof
    exit
fi

# }}}

# {{{ Init Direnv chdir hooks

eval "$(direnv hook zsh)"

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
