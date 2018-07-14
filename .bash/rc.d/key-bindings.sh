#
# Bash key-bindings
#

[[ "$TERM" == dumb ]] && return

# vi-mode
set -o vi

bind '"\ep":history-search-backward'
bind '"\en":history-search-forward'
bind '"\e\C-i":dynamic-complete-history'

# vim:fenc=utf-8:ft=sh:
