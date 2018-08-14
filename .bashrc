# $Id: ~/.bashrc wandsas 2018/07/13

# .bashrc is invoked by non-login interactive shells and by login
# interactive shells via a hook in my .bash_profile; also when bash is
# invoked from rshd (or similar?)

# Allow disabling of all meddling with the environment
[ -n "$INHERIT_ENV" ] && return 0

shopt -qs extglob

# {{{ Environment

[ -r ~/.bashenv ] && . ~/.bashenv

# }}}

sh_load_status .bashrc

# {{{ source /etc/bashrc

if [ -f /etc/bashrc ]; then
    sh_load_status '/etc/bashrc'
    . /etc/bashrc
else
    [ -r $ZDOTDIR/.sysbashrc ] && . $ZDOTDIR/.sysbashrc
fi

# }}}




# {{{ Source system bashrc

[[ -f "/etc/bash/bashrc" ]] && source /etc/bash/bashrc

# }}}

# {{{ Source user profile

[[ -r "$HOME/.profile" ]] && source $HOME/.profile

# }}}

# {{{ Prevent PATH duplicates

PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# }}}

# {{{ Are we running an interactive shell?

[[ -n "$shell_interactive" ]] || return

# }}}

# {{{ Running bash hooks

for f in ~/.bash/{functions,rc.d}/*.sh; do
    [[ -r "$f" ]] && source $f
done
unset f

# }}}

# {{{ Init Direnv chdir hooks

eval $(direnv hook bash)

# }}}k

# {{{ Preexec subshells

export __bp_enable_subshells="true"

# }}}

# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0:

# -*- mode: sh -*-
