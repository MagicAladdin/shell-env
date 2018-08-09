# $Id: ~/.zsh/rc.d/dirstack.sh wandsas 2018/08/09
#
# Zsh dirstack handling
# https://github.com/grml/grml-etc-core

DIRSTACK_FILE=${ZDOTDIR:-$HOME}/.zdirs
DIRSTACKSIZE=20

if [[ -f ${DIRSTACK_FILE} ]] && [[ ${#dirstack[*]} -eq 0 ]] {
  dirstack=( ${(f)"$(< $DIRSTACK_FILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
}

chpwd_functions+=( chpwd_dirpersist )

chpwd_dirpersist () {
    if (( $DIRSTACKSIZE <= 0 )) || [[ -z $DIRSTACK_FILE ]] { return; }
    local -ax my_stack
    my_stack=( ${PWD} ${dirstack} )
    builtin print -l ${(u)my_stack} >! ${DIRSTACK_FILE}
}

# vim:fenc=utf-8:ft=zsh:
