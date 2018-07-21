#
# Init gpg-agent for ssh
#

(( $+commands[gpg-agent] )) || return

export GPG_TTY=$(tty)

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

function _gpg-agent-update-tty {
    gpg-connect-agent updatestartuptty /bye >/dev/null
}

autoload -Uz add-zsh-hook
add-zsh-hook preexec _gpg-agent-update-tty

# vim:fenc=utf-8:ft=zsh:ts=4:sts=4:sw=4:et:ci:pi:
