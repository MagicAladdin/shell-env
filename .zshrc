# $Id: ~/.zshrc wandsas 2018/08/10
#
# Wandsas ~/.zshrc

# Allow disabling of entire environment suite
[[ -n "$INHERIT_ENV" ]] && return

# shls1
#sh_load_status .zshrc

# {{{ Configure ZSH features

# Empty means loading the feature

# 1. https://github.com/psprint/zsh-morpho
ZSHRC_SKIP_ZMORPHO=

# 2. https://github.com/zdharma/history-search-multi-word
ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD=

# 3. https://github.com/zdharma/fast-syntax-highlighting
ZSHRC_SKIP_FAST_SYNTAX_HIGHLIGHTING=

# 4. https://github.com/zsh-users/zsh-autosuggestions
ZSHRC_SKIP_AUTOSUGGESTIONS=

ZSHRC_KEEP_FUNCTIONS=

# }}}

# {{{ Profiling

[[ -n "$ZSH_PROFILE_RC" ]] && zmodload zsh/zprof

# }}}

# {{{ Options

# See man zshoptions(1)

# shls2
#sh_load_status 'setting options'

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

# }}}

# {{{ Environment

# shls3
sh_load_status 'setting environment'

# {{{ Infopath

typeset -U infopath
infopath=(
    $HOME/{share/,}info(N)
    /usr/{local/,}share/info/(N)
    $infopath
        )

# }}}

# {{{ Manpath

typeset -U manpath
manpath=(
    $ZDOTDIR/share/man/(N)
    /usr/{,local/,}share/man(N)
    $manpath[@]
    )

# }}}
setopt prompt_subst
autoload -U promptinit && promptinit

prompt wandsas2

#autoload -Uz compinit && compinit

# Variables used by zsh

# {{{ Choose word delimiter characters in line editor

# The manual defines WORDCHARS as "a list of non-alphanumeric
# characters considered part of a word by the line editor."
# Nevertheless the effect is not intuitive and best understood by
# experimenting with the value.
WORDCHARS='>~'

# }}}

# {{{ Maximum size of completion listing

#LISTMAX=0    # Only ask if line would scroll off screen
LISTMAX=1000  # "Never" ask

# }}}

# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"

# }}}

# }}}

# {{{ Miscellaneous

#sh_load_status 'miscellaneous'

# {{{ ls colours

(( $+commands[dircolors] )) && () {
    if [[ -r "~/.dir_colors" ]] {
        eval $(dircolors -b ~/.dir_colors)
    } elif [[ -r "/etc/DIR_COLORS" ]] {
        eval $(dircolors -b /etc/DIR_COLORS)
    } else { eval $(dircolors) }
}

autoload -U is-at-least

is-at-least 3.1.5 && () {
    zmodload -i zsh/complist

    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#)*=00=01:32'
    # completion colours
    zstyle ':completion:*' list-colors $LS_COLORS
}

# Is GNU ls available?
if ls --color=auto / >/dev/null 2>&1; then
  alias ls='command ls --color=auto'
elif ls -G / >/dev/null 2>&1; then
  alias ls='command ls -G'
fi
alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'

# }}}

# {{{ grep colors

if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
  alias  grep='command grep  --color=auto'
  alias egrep='command egrep --color=auto'
  alias ngrep='command ngrep --color=auto'
  alias zgrep='command zgrep --color=auto'
fi

# }}}

# {{{ less colors

(( ${terminfo[colors]:-0} >= 8 )) && () {
  export LESS_TERMCAP_mb=$'\E[1;31m'
  export LESS_TERMCAP_md=$'\E[1;38;5;74m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[1;3;5;246m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[1;32m'
}

# }}}

# {{{ Don't always autlogout

unset TMOUT

# }}}

# }}}

# {{{ Specific to local setups

#sh_load_status 'local hooks'

#run_hooks .zsh/rc.d

# }}}

# {{{ Profiling report

if [[ -n "$ZSHRC_PROFILE_RC" ]]; then
    zprof >! ~/zshrc.zprof
    exit
fi

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
