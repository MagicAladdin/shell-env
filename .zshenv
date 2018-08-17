# $Id: ~/.zshenv wandsas 2018/08/10

# Best viewed in emacs folding mode (folding.el).
# (That's what all the # {{{ and # }}} are for.)
#
# This gets run even for non-interactive shells;
# keep it as fast as possible.
#
# N.B. This is for zsh-specific environment stuff.  Put generic,
# portable environment settings in .shared_env instead, so that they
# take effect for bash and ksh.

# Allow disabling of entire environment suite
[[ -n "$INHERIT_ENV" ]] && return

# Stop bad system-wide scripts interfering.
setopt NO_global_rcs

# {{{ ZDOTDIR

export ZDOTDIR="${ZDOTDIR:-$HOME}"

# }}}

# {{{ Sourcing .shared_env

[[ -r $ZDOTDIR/.shared_env ]] && . $ZDOTDIR/.shared_env

# }}}

sh_load_status '.zshenv already started before .shared_env'

setopt extended_glob

# 077 would be more secure, but 022 is generally quite realistic
umask 022

# {{{ path / manpath

sh_load_status 'search paths'

typeset -U PATH path
export PATH

path=(
    $ZDOTDIR/{.local/,.go/,.cargo/,.cask/,}bin
    $path
    )

typeset -U manpath
export MANPATH

# }}}

# {{{ ld_library_path

typeset -TU LD_LIBRARY_PATH ld_library_path

# }}}

# {{{ Perl5 libraries

typeset -TU PERL5LIB perl5lib

# }}}

# {{{ Gopath

export GOPATH=$ZDOTDIR/.go

# }}}

# {{{ Python libraries

typeset -TU PYTHONPATH pythonpath
export PYTHONPATH

pythonpath=(
    $HOME/.local/lib64/python{2.*,3.*}/site-packages(N)
    /usr/local/lib64/python{2.*,3.*}/sitepackages(N)
    $pythonpath
    )

# }}}

# {{{ Ruby libraries

typeset -TU RUBYLIB rubylib
export RUBYLIB

rubylib=(
    $HOME/.local/lib/ruby/{site_ruby,}(N)

    $rubylib
    )

# }}}

# {{{ fpath

fpath=(
    $ZDOTDIR/.[z]sh/{$ZSH_VERSION/*.zwc,functions}(N)
    $fpath
    )

for dirname in $fpath; do
    case "$dirname" in
	($ZDOTDIR/.zsh*) fns=( $dirname/*~*~(-N.x:t) ) ;;
		          *) fns=( $dirname/*~*~(-N.:t ) ) ;;
    esac
    (( $#fns )) && autoload "$fns[@]"
done

# }}}

# {{{ Running hooks specific to hosts

run_hooks .zsh/env.d

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
