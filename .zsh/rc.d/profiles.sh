# $Id: ~/.zsh/rc.d/profiles.sh wandsas 2018/08/09
#
# Zsh directory based profiles
# https://github.com/grml/grml-etc-core
#
#   zstyle ':chpwd:profiles:/usr/src/grml(|/|/*)'   profile grml
#   zstyle ':chpwd:profiles:/usr/src/debian(|/|/*)' profile debian
#   chpwd_profiles
#
# For details see the `grmlzshrc.5' manual page.

[[ $USER != "wandsas" ]] && return

zstyle ':chpwd:profiles:$HOME/android(|/|/*)'   profile android
zstyle ':chpwd:profiles:$HOME/kernel(|/|/*)'    profile kernel

chpwd_profile_android () {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return
    export GIT_AUTHOR_NAME="android"
    export GIT_AUTHOR_EMAIL=$USER@$HOST
    export GIT_COMMITTER_NAME=$GIT_AUTHOR_NAME
    export GIT_COMMITTER_EMAIL=$GIT_AUTHOR_EMAIL
}

chpwd_profile_kernel () {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return
    export KERNEL_DIR=/usr/src/linux
    export KBUILD_OUTPUT=/usr/src/kernel
}

chpwd_profile_default () {
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return
    unset GIT_AUTHOR_NAME
    unset GIT_AUTHOR_EMAIL
    unset GIT_COMMITTER_NAME
    unset GIT_COMMITTER_EMAIL
    unset KERNEL_DIR
    unset KBUILD_OUTPUT
}

function chpwd_profiles() {
    local profile context
    local -i reexecute

    context=":chpwd:profiles:$PWD"
    zstyle -s "$context" profile profile || profile='default'
    zstyle -T "$context" re-execute && reexecute=1 || reexecute=0

    if (( ${+parameters[CHPWD_PROFILE]} == 0 )); then
        typeset -g CHPWD_PROFILE
        local CHPWD_PROFILES_INIT=1
        (( ${+functions[chpwd_profiles_init]} )) && chpwd_profiles_init
    elif [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_leave_profile_$CHPWD_PROFILE]} )) \
            && chpwd_leave_profile_${CHPWD_PROFILE}
    fi
    if (( reexecute )) || [[ $profile != $CHPWD_PROFILE ]]; then
        (( ${+functions[chpwd_profile_$profile]} )) && chpwd_profile_${profile}
    fi

    CHPWD_PROFILE="${profile}"
    return i0
}

chpwd_functions=(${chpwd_functions} chpwd_profiles)

# Init profile
chpwd_profiles

directory_profiles_active () {
    (( ${+functions[chpwd_profiles]} )) && print "directory profiles active"
}

# vim:fenc=utf-8:ft=zsh:
