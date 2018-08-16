# $Id: ~/.zsh/rc.d/03-zsh-options.sh wandsas 2018/08/09
#
# ZSH options
#

# See man zshoptions(1)

# Expansion and globbing options
setopt EXTENDED_GLOB            # do not forget to quote '^', '~' and '#'!
setopt NO_GLOB_DOTS             # * shouldnt match dotfiles, ever
setopt NO_SH_WORD_SPLIT         # use zsh style word splitting

# input/output options
setopt RM_STAR_SILENT           # do not ask for confirmation on rm *
setopt NO_FLOW_CONTROL          # disable start/stop characters in shell editor

# job options
setopt LONG_LIST_JOBS           # display PID when suspending processes as well
setopt NOTIFY                   # report background job status immediately

# cd options
setopt AUTO_CD                  # command can not be executed -> try cd
setopt AUTO_PUSHD               # cd push old directory to dirstack
setopt CDABLE_VARS
setopt PUSHD_IGNORE_DUPS        # don not push dups on the dirstack

# completion options
setopt HASH_LIST_ALL            # whenever completion is attempted, make sure command path
                                # is hashed first

# zle options
setopt NO_HUP                   # do not send SIGHUP to background processes when the shell exits
setopt NO_BEEP                  # do not beep on error in zle
setopt INTERACTIVE_COMMENTS     # enable comments in interactive shell

setopt UNSET                    # do not error out when unset parameters
setopt MULTIOS                  # perform implicit tees or cats when multiple redirections are attempted.

setopt LIST_PACKED              # try to make the completion list smaller (occupying less lines)
                                # by printing the matches in columns with different widths.
setopt NO_SINGLE_LINE_ZLE       # reduces the effectiveness of the zsh line editor. As is
                                # has no effect on shell syntax, many uses may wish to disable
                                # this option.
setopt SH_WORD_SPLIT            # Causes field splitting to be performed on unquoted parameter
                                # expansions. This option has nothing to do with word-splitting
setopt SHORT_LOOPS              # Allow the short forms of for, repeat, select, if, function
setopt NO_SH_FILE_EXPANSION     # Perform filename expansion (e.g., ~ expansion) before
                                # parameter expansion, command substitution, arithmetic
                                # expansion and brace expansion. If this option is unset,
                                # it is performed after brace expansion, so things like
                                # ‘~$USERNAME’ and ‘~{pfalstad,rc}’ will work.
setopt NO_NULL_GLOB
setopt NUMERIC_GLOB_SORT        # If numeric filenames are matched by a filename generation
                                # pattern, sort the filenames numerically rather than
                                # lexicographically.
setopt PATH_DIRS                # Perform a path search even on command names with slashes
                                # in them. Thus if ‘/usr/local/bin’ is in the user’s path, and
                                # he or she types ‘X11/xinit’, the command will be executed.

# vim:fenc=utf-8:ft=zsh:
