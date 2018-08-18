# $Id: ~/.zlogin wandsas 2018/08/18

start_ssh_agent () {
    envfile=$TMPDIR/ssh-agent-env
    if [[ -r $envfile ]] {
        while read line; do
		    export $line
        done <$envfile
    } else {
        eval export $(gpg-agent --homedir ~/.gnupg --use-standard-socke --daemon --sh)
	    eval export $(ssh-agent -s)
	    printf "GPG_AGENT_INFO=$GPG_AGENT_INFO\nSSH_AUTH_SOCK=$SSH_AUTH_SOCK\nSSH_AGENT_PID=$SSH_AGENT_PID\n" >$envfile
    }
    unset envfile
}

#start_ssh_agent

# vim:fenc=utf-8:ft=zsh:
