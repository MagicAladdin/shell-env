#
# Wandsas ~/.zshenv
#

# {{{ ZDOTDIR

export ZDOTDIR=${ZDOTDIR:-$HOME}

# }}}

# {{{ Source user profile in bash compatibility mode

[[ -r "$HOME/.profile" ]] && () {
    emulate -L sh
    setopt ksh_glob no_sh_glob brace_expand no_nomatch
    source ~/.profile
}

# }}}

setopt EXTENDED_GLOB

# {{{ Prevent duplicates in path variables

typeset -U PATH path
export PATH

path=(
    ~/{.local/,go/,.cask/}bin
    $path
    )

typeset -U manpath
export MANPATH

typeset -TU LD_LIBRARY_PATH ld_library_path
typeset -TU PERL5LIB perl5lib

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

# vim:fenc=utf-8:ft=zsh:ts=4:sts=4:sw=4:et:fdm=marker:foldlevel=0:
