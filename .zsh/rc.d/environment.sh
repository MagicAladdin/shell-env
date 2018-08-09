# $Id: ~/.zsh/rc.d/environment.sh wandsas 2018/08/09
#
# Environment variables setup
#

NULLCMD=:
READNULLCMD=less

# Turn off mail checking
MAILCHECK=0

MAIL="$HOME/Maildir"

# Show time/memory for commands running longer than this number of seconds:
LOGCHECK=60
WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"

REPORTTIME=5
TIMEFMT='%J  %M kB %*E (user: %*U, kernel: %*S)'

# watch for everyone but me and root
watch=(notme root)

# vim:fenc=utf-8:ft=zsh:
