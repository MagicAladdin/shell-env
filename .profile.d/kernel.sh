# $Id: ~/.profile.d/kernel.sh wandsas 2018/08/11
#
# Wandsas kernel settings

# Are we root, abort!
[[ `id -u` = 0 ]] && return

export KERNEL_DIR=/usr/src/linux
export KBUILD_OUTPUT=/usr/src/kbuild

# vim:fenc=utf-8:ft=sh:
