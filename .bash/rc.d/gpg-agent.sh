#
# Init gpg-agent for ssh
#

check_com gpg-agent || return

export GPG_TTY=$(tty)

unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

_gpg-agent-update-tty () {
    echo reloadagent
	gpg-connect-agent reloadagent /bye >/dev/null 2>&1
}

preexec_functions+=(_gpg-agent-update-tty)

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:sw=4:et:ai:ci:pi:
