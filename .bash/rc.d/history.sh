#
# Bash history
#

HISTSIZE=${HISTSIZE:-10000}
HISTFILESIZE=${HISTFILESIZE:-10000}
HISTTIMEFORMAT="%F %H:%M:%S "

# ignorespace. ignoredups, ignoreboth, erasedups
HISTCONTROL=${HISTCONTROL:-ignorespace:erasedups}
AUTOFEATURE=${AUTOFEATURE:-true autotest}

function rh {
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# Save each command to the history file as it's executed.  #517342
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
PROMPT_COMMAND='history -a'

# vim:fenc=utf-8:ft=sh:
