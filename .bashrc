# $Id: ~/.bashrc wandsas 2018/07/13

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

# {{{ Init direnv hooks

eval "$(direnv hook bash)"

# }}}

# {{{ preexec subshells

export __bp_enable_subshells="true"

# }}}

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:sw=4:et:fdm=marker:foldlevel=0:
