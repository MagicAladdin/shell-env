# $Id: ~/.zsh/rc.d/my-zsh-prompt.sh wandsas 2018/08/09
#
# My extravagant zsh prompt

autoload -U promptinit && promptinit

if [[ `id -u` = 0 ]] {
    prompt wandsas      # root's prompt
} else {
    #prompt wandsas2
    prompt pure
}

[[ -n "$SCHROOT_CHROOT_NAME" ]] && PS1="($SCHROOT_CHROOT_NAME) $PS1"

# vim:fenc=utf-8:ft=zsh:
