#
# Wandsas zsh prompt
#

autoload -U promptinit && promptinit

prompt wandsas2

[[ -n "$SCHROOT_CHROOT_NAME" ]] && PS1="($SCHROOT_CHROOT_NAME)$PS1"

# vim:fenc=utf-8:ft=zsh:
