# $Id: ~/.zsh/rc.d/history.sh wandsas 2018/08/09
#
# ZSH history
#

# set location of the history file
HISTFILE=$HOME/.zhistory

HISTSIZE=10000
SAVEHIST=10000

# Perfom textual history expansion
# csh-style, treating the character ´!´ specially.
setopt BANG_HIST

# Expire a duplicate event first when trimming history-
setopt HIST_EXPIRE_DUPS_FIRST

# Save each command's beginning timestamp (in seconds since the epoch)
# and the duration (in seconds) to history file.
# ‘: <beginning time>:<elapsed seconds>;<command>’.
setopt EXTENDED_HISTORY

# This options works like APPEND_HISTORY except that new history lines are
# added to the ${HISTFILE} incrementally (as soon as they are entered),
# rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY

# Shares history across all sessions rather than waiting for a new shell
# invocation to read the history file.
setopt SHARE_HISTORY

# If a new command line being added to the history list duplicates an older
# one, the older command is removed from the list.
setopt HIST_IGNORE_ALL_DUPS

# remove command from history when first character on line is a space.
setopt HIST_IGNORE_SPACE

# Whenever the user enters a line with history expansion, don’t execute the
# line directly. Instead perform history expansion and reload the line into
# the editing buffer.
setopt HIST_VERIFY

# vim:fenc=utf-8:ft=zsh:
