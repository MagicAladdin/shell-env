# $Id: libssh.zsh wandsas 2018/07/21


#
# Copy the function to .zlogin, or source libssh in the .zlogin file.
#
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

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:
