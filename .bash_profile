# $Id: ~/.bash_profile wandsas 2018/07/13
#
# Wandsas .bash_prfole

# .bash_profile is invoked in preference to .profile by interactive
# login shells, and by non-interactive shells with the --login option.

: .bashrc starts # for debugging with -x

# Allow disabling of all meddling with the environment
[ -n "$INHERIT_ENV" ] && return 0

[[ -r "$HOME/.bashrc" ]] && source $HOME/.bashrc

# {{{

#. $ZDOT_RUN_HOOKS .bash/profile.d

#: .bashrc ends # for debugging with -x

# vim:fenc=utf-8:ft=sh:
