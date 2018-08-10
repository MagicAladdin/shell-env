# $Id: ~/.profile wandsas 2018/07/13

[[ -n "$profile_loaded" ]] && return

echo "$ZDOTDIR/.profile loaded"

[[ -r "/etc/profile" ]] && source /etc/profile

case "$-" in
    (*i*) shell_interactive=y ;;
      (*) shell_interactive=  ;;
esac

check_com locale && {
    export LANG=en_US.UTF-8
    export LC_COLLATE=C
    unset LC_ALL
}

export EDITOR=nvim
export PAGER=less
export BROWSER=lynx

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

export GOPATH=${GOPATH:-~/.go}
export GOTMP=/tmp

export GHQ_ROOT=$HOME/repos

export PYTHONPATH=$HOME/.local/lib64/python3.6/site-packages:$PYTHONPATH

export NODE_PATH=${XDG_CONFIG_HOME:-$HOME/.config}/node_modules

export KERNEL_DIR=/usr/src/linux
export KBUILD_OUTPUT=/usr/src/kbuild

export GTK2_RC_FILES=${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE="GTK+"
export NO_AT_BRIDGE=1

export LPASS_AGENT_TIMEOUT=0
export LPASS_DISABLE_PINENTRY=1
export PASSWORD_STORE_ENABLE_EXTENSIONS=true
export SUDO_ASKPASS=/usr/bin/lxqt-openssh-askpass

[[ -d "$GOPATH/bin" ]]      && pathmunge $GOPATH/bin
[[ -d "$HOME/.rust/bin" ]]  && pathmunge $HOME/.rust/bin
[[ -d "$HOME/.cask/bin" ]]  && pathmunge $HOME/.cask/bin
[[ -d "$HOME/.local/bin" ]] && pathmunge $HOME/.local/bin
[[ -d "$HOME/bin" ]]        && pathmunge $HOME/bin

for f in $ZDOTDIR/.profile.d/*.sh; do
    [[ -r "$f" ]] && source $f
done
unset f

profile_loaded=y

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:sw=4:et:fdm=marker:foldlevel=0:
