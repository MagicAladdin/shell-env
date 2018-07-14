#
# Dircolors
#

if [ -r "$HOME/.dir_colors" ]; then
    eval $(dircolors -b $HOME/.dir_colors)
elif [ -r "/etc/DIR_COLORS" ]; then
    eval $(dircolors -b /etc/DIR_COLORS)
else
    eval $(dircolors)
fi


if ls --color=auto / >/dev/null 2>&1; then
    alias ls='command ls --color=auto'
elif ls -G / >/dev/null 2>&1; then
    alias ls='command ls -G'
fi
alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'


if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
    alias  grep='command grep  --color=auto'
    alias egrep='command egrep --color=auto'
    alias ngrep='command ngrep --color=auto'
    alias zgrep='command zgrep --color=auto'
fi


export LESS_TERMCAP_mb=$'\E[1;31m'
export LESS_TERMCAP_md=$'\E[1;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[1;3;5;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[1;32m'

# vim:fenc=utf-8:ft=sh:
