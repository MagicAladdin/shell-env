# $Id: ~/.bashrc wandsas 2018/07/13

# .bashrc is invoked by non-login interactive shells and by login
# interactive shells via a hook in my .bash_profile; also when bash is
# invoked from rshd (or similar?)

: .bashrc starts # for debugging with -x

# Allow disabling of all meddling with the environment
[ -n "$INHERIT_ENV" ] && return 0

#shopt -qs extglob

# {{{ Environment

[ -r ~/.bashenv ] && . ~/.bashenv

# }}}

sh_load_status .bashrc

# {{{ source /etc/bashrc

if [ -f /etc/bashrc ]; then
    sh_load_status '/etc/bashrc'
    . /etc/bashrc
fi

# }}}

# {{{ Options

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

# }}}

# {{{ Prevent PATH duplicates

PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# }}}

# {{{ Are we running an interactive shell?

[[ -z "$shell_interactive" ]] && return

# }}}

# {{{ Dircolors

if [[ -r "$HOME/.dir_colors" ]]; then
  eval $(dircolors -b $HOME/.dir_colors)
elif [[ -r "/etc/DIR_COLORS" ]]; then
  eval $(dircolors -b /etc/DIR_COLORS)
else
  eval $(dircolors)
fi

# Check if GNU ls is available, or BSD ls implementation for colors
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

if check_com less; then
  export LESS_TERMCAP_mb=$'\E[1;31m'
  export LESS_TERMCAP_md=$'\E[1;38;5;74m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[1;3;5;246m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[1;32m'
fi

# }}}

# {{{ Running bash hooks

. $ZDOT_RUN_HOOKS .bash/rc.d

# }}}

# {{{ Init Direnv hook

eval $(direnv hook bash)

# }}}

export __bp_enable_subshells="true"

: .bashrc ends # for debugging with -x

# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0:
