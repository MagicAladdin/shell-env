# $Id: ~/.bashrc wandsas 2018/07/13

# .bashrc is invoked by non-login interactive shells and by login
# interactive shells via a hook in my .bash_profile; also when bash is
# invoked from rshd (or similar?)

: .bashrc starts # for debugging with -x

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

# {{{ Prevent PATH duplicates

PATH=$(echo -n $PATH | awk -v RS=: -v ORS=: '!x[$0]++' | sed "s/\(.*\).\{1\}/\1/")

# }}}

if which emacs >/dev/null 2>&1; then
    e () {
        emacs "$@" 2>&1 &
    }
fi
# {{{ Are we running an interactive shell?

[[ -n "$shell_interactive" ]] || return

# }}}

# {{{ Running bash hooks

. $ZDOT_RUN_HOOKS .bash/rc.d

: .bashrc ends # for debugging with -x

# }}}

# {{{ Init Direnv hook

eval $(direnv hook bash)

# }}}k

# {{{ Preexec subshells

export __bp_enable_subshells="true"

# }}}

# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0:

# -*- mode: sh -*-
