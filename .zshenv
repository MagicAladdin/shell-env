# $Id: ~/.zshenv wandsas 2018/08/10
#
# Wandsas ~/.zshenv

# {{{ zshenv already loaded?

[[ -n "$zshenv_loaded" ]] && return

# }}}

# {{{ ZDOTDIR

export ZDOTDIR=${ZDOTDIR:-$HOME}

# }}}

# {{{ DEBUG

#DEBUG=y

# }}}

# {{{ Source user profile in bash compatibility mode

[[ -r "$ZDOTDIR/.profile" ]] && () {
    emulate -L sh
    setopt ksh_glob no_sh_glob brace_expand no_nomatch
    source $ZDOTDIR/.profile
}

# }}}

setopt EXTENDED_GLOB

# {{{ path / manpath

typeset -U PATH path
export PATH

path=(
    $ZDOTDIR/{.local/,.go/,.cargo/,.cask/}bin
    $path
    )

typeset -U manpath
export MANPATH

typeset -TU LD_LIBRARY_PATH ld_library_path
typeset -TU PERL5LIB perl5lib

# }}}

# {{{ gopath

export GOPATH=$ZDOTDIR/.go

# }}}

# {{{ pythonpath

typeset -TU PYTHONPATH pythonpath
export PYTHONPATH

pythonpath=(
    $HOME/.local/lib64/python{2.*,3.*}/site-packages(N)
    $pythonpath
    )

# }}}

# {{{ rubylib

typeset -TU RUBYLIB rubylib
export RUBYLIB

rubylib=(
    $HOME/.local/lib/ruby/{site_ruby,}(N)
    $rubylib
    )

# }}}

# {{{ fpath

fpath=(
    $ZDOTDIR/.zsh/{$ZSH_VERSION/*.zwc,functions}(N)
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

# {{{ zshenv loaded

zshenv_loaded=y

debug "$ZDOTDIR/.zshenv loaded"

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
