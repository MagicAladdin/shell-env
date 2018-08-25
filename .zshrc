# $Id: ~/.zshrc wandsas 2018/08/10
#
# Wandsas ~/.zshrc

# Allow disabling of entire environment suite
[[ -n "$INHERIT_ENV" ]] && return

sh_load_status .zshrc

# {{{ Enable ZSH features

# Empty means loading the feature

# 1. https://github.com/psprint/zsh-morpho
ZSHRC_SKIP_ZMORPHO=

# 2. https://github.com/zdharma/history-search-multi-word
ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD=

# 3. https://github.com/zdharma/fast-syntax-highlighting
ZSHRC_SKIP_FAST_SYNTAX_HIGHLIGHTING=

# 4. https://github.com/zsh-users/zsh-autosuggestions
ZSHRC_SKIP_AUTOSUGGESTIONS=y

ZSHRC_KEEP_FUNCTIONS=

# }}}

# {{{ Profiling

[[ -n "$ZSH_PROFILE_RC" ]] && zmodload zsh/zprof

# }}}

# {{{ Options

# See man zshoptions(1)

sh_load_status 'setting options'

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

# {{{ Modules

# See man zshmodules

# Zsh edit small files with the command line editor
autoload -U zed

# Zsh massive renaming
autoload -U zmv
alias mmv='noglob zmv -W'

# Smart pasting and escaping
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Smart URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Helping system
autoload -Uz run-help run-help-sudo run-help-git run-help-openssl run-help-ip

# Compile functions
check_com precompile && () {
    autoload -U precompile && precompile
}

# Don't correct these commands
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

# For extensions, we use the defaults of zsh-mime-setup
# see /etc/mailcap, /etc/mime.types for system configs
# and ~/.mailcap, ~/.config/mimeapps.list for user configs.
zstyle ":mime:*" current-shell true
zsh-mime-setup

# }}}

# {{{ Environment

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

# Variables used by zsh

# {{{ Choose word delimiter characters in line editor

# The manual defines WORDCHARS as "a list of non-alphanumeric
# characters considered part of a word by the line editor."
# Nevertheless the effect is not intuitive and best understood by
# experimenting with the value.
WORDCHARS='>~'

# }}}

# {{{ Save a large history

HISTFILE=~/.zshhistory
HISTSIZE=10000
SAVEHIST=10000

# }}}

# {{{ Maximum size of completion listing

LISTMAX=1000  # "Never" ask

# }}}

# {{{ Watching for other users

LOGCHECK=60
WATCHFMT="[%B%t%b] %B%n%b has %a %B%l%b from %B%M%b"

# }}}

# }}}

# {{{ Prompt

autoload -U promptinit && promptinit

setopt prompt_subst

if [[ `id -u` = 0 ]] {
    prompt wandsas      # root's prompt
} else {
    prompt wandsas3
    #prompt adam2 8bit
    #prompt clover
}

[[ -n "$SCHROOT_CHROOT_NAME" ]] && PS1="($SCHROOT_CHROOT_NAME) $PS1"

# }}}

# {{{ Completions

sh_load_status 'completion system'

autoload -U complist
autoload -U compinit && compinit -d $ZDOTDIR/.zcompdump

# {{{ Completion options

setopt COMPLETE_IN_WORD     # complete from both ends of a word
setopt ALWAYS_TO_END        # move cursor to the end of a completed word
setopt PATH_DIRS            # perform path search even on command names with slashes
setopt AUTO_MENU            # show completion menu on a successive tab press
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # if completed parameter is a directory, add a trailing slash
setopt NO_MENU_COMPLETE     # do not autoselect the first completion entry
setopt NO_FLOW_CONTROL      # disable start/stop characters in shell editor
setopt CORRECT              # smart completion correction

# }}}

# {{{ General completion technique

zstyle ':completion:*' completer _complete _prefix _ignored _complete:-extended

zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

zstyle ':completion:*:approximate-one:*'  max-errors 1
zstyle ':completion:*:approximate-four:*' max-errors 4

# e.g. f-1.j<TAB> would complete to foo-123.jpeg
zstyle ':completion:*:complete-extended:*' \
  matcher 'r:|[.,_-]=* r:|=*'

# }}}

# {{{ Completion Caching

zstyle ':completion:*'              use-cache  yes
zstyle ':completion:*:complete:*'   cache-path ${ZDOTDIR:-${HOME}/.cache}

# }}}

# {{{ Expand partial paths

# e.g. /u/s/l/D/fs<TAB> would complete to
#      /usr/src/linux/Documentation/fs
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# }}}

# {{{ Approximate completer

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:' max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# }}}

# {{{ don't complete backup files (e.g. bin/foo~) as executables

zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(*\~)'

# }}}

# {{{ Don't complete uninteresting users...

zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp lighttpd mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

# }}}

# {{{ Menu completion

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'        insert-unambiguous true
zstyle ':completion:*:corrections'      format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:correct:*'        original true

# activate color-completion
zstyle ':completion:*:default'          list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*'           tag-order local-directories directory-stack path-directories
zstyle ':completion:*:-tilde-:*'        group-order 'named-directories' 'path-directories' 'expand'

# automatically complete 'cd -<tab>' and 'cd -<ctrl-d>' with menu
# INFO: maybe slow
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

# insert all expansions for expand completer
zstyle ':completion:*:expand:*'         tag-order all-expansions
zstyle ':completion:*:history-words'    list false

# activate menu
zstyle ':completion:*:history-words'    menu yes
zstyle ':completion:*:history-words'    list false

# ignore duplicate entries
zstyle ':completion:*:history-words'    remove-all-dups yes
zstyle ':completion:*:history-words'    stop yes

# Docker completion
zstyle ':completion:*:*:docker:*'       option-stacking yes
zstyle ':completion:*:*:docker:-*:*'    option-stacking yes

# match uppercase from lowercase
zstyle ':completion:*'                  matcher-list 'm:{a-z}={A-Z}'

# }}}

# {{{ Output formatting

# Separate matches into groups
zstyle ':completion:*:matches'      group 'yes'

# Describe each match group.
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d% --%f'

# if there are more than 5 options allow selecting from a menu
zstyle ':completion:*:*:*:*:*'      menu select

# Messages/Warnings format
zstyle ':completion:*:messages'     format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings'     format ' %F{red}-- no matches found --%f'

zstyle ':completion:*:default'      list-prompt '%S%M matches%s'
zstyle ':completion:*'              format ' %F{yellow}-- %d --%f'

# Describe options in full
zstyle ':completion:*:options'      description 'yes'
zstyle ':completion:*:options'      auto-description '%d'

# activate color-completion
zstyle ':completion:*:default'      list-colors ${(s.:.)LS_COLORS}

# }}}

# {{{ process completion

zstyle ':completion:*:*:*:*:processes'  menu yes select
zstyle ':completion:*:*:*:*:processes'  force-list always
zstyle ':completion:*:*:*:*:processes'  command 'ps -u $LOGNAME -o pid,user,command -w'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'

zstyle ':completion:*:*:kill:*'         menu yes select
zstyle ':completion:*:*:kill:*'         force-list always
zstyle ':completion:*:*:kill:*'         insert-ids single

zstyle ':completion:*:*:killall:*'      menu yes select
zstyle ':completion:*:killall:*'        force-list always

# }}}

# {{{ array/association subscripts

# When completing inside array or association subscripts, the array elements
# are more useful than parameters so complete them first
zstyle ':completion:*:*:-subscript-:*'  tag-order indexes parameters

# }}}

# {{{ verbose completion information

zstyle ':completion:*'                  verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'     verbose false

# }}}

# {{{ define files to ignore for zcompile

zstyle ':completion:*:*:zcompile:*'     ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'           prompt 'correct to: %e'

# }}}

# {{{ Ignore completion functions for commands you don't have:

zstyle ':completion::(^approximate*):*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# }}}

# {{{  Manuals
zstyle ':completion:*:manuals'          separate-sections true
zstyle ':completion:*:manuals.(^1*)'    insert-sections true

# }}}

# {{{ Add a special SUDO_PATH for completion of sudo & friends

[[ $UID -eq 0 ]] || () {
	local -T SUDO_PATH sudo_path
	local -U sudo_path
  sudo_path=($path {,/usr{,/local}}/sbin(N-/) $HOME/{.go/,.rust/,.local/,}bin)
	zstyle ":completion:*:(su|sudo|sux|sudox):*" environ PATH="$SUDO_PATH"
}

# }}}

# {{{ provide .. as a completion

zstyle ':completion:*' special-dirs ..

# }}}

# {{{ rehash on completion so new installed program are found automatically:

function _force_rehash () {
    (( CURRENT == 1 )) && rehash
    return 1
}

# }}}

# {{{ Smart completion correction

zstyle -e ':completion:*' completer '
if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
    _last_try="$HISTNO$BUFFER$CURSOR"
    reply=(_complete _match _ignored _prefix _files)
else
    if [[ $words[1] == (rm|mv) ]] ; then
        reply=(_complete _files)
    else
        reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
    fi
fi'

# }}}

# {{{ GNU generics

# Works with commands that provide standard --help options
for compcom in cp df feh gpasswd head mv pal stow uname; do
    [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
done;
unset compcom

# }}}

# {{{ Usernames

run_hooks .zsh/users.d
zstyle ':completion:*' users $zsh_users

# }}}

# {{{ Hostnames

# Extract hosts from /etc/hosts
# ~~ no glob_subst -> don't treat contents of /etc/hosts like pattern
# (f) shorthand for (ps:\n:) -> split on \n ((p) enables recognition of \n etc.)
# %%\#* -> remove comment lines and trailing comments
# (ps:\t:) -> split on tab
# ##[:blank:]#[^[:blank:]]# -> remove comment lines

: ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}}

  # _ssh_known_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*})

zsh_hosts=(
    "$_etc_hosts[@]"
    localhost
)

run_hooks .zsh/hosts.d
zstyle ':completion:*' hosts $zsh_hosts

# }}}

# {{{ (user, host) account pairs

run_hooks .zsh/accounts.d
zstyle ':completion:*:my-accounts'    users-hosts "$my_accounts[@]"
zstyle ':completion:*:other-accounts' users-hosts "$other_accounts[@]"

# }}}

# {{{ pdf

compdef _pdf pdf

# }}}

# }}}

# {{{ Miscellaneous

sh_load_status 'miscellaneous'

# {{{ ls colors

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

# {{{ No autlogout

unset TMOUT

# }}}

# }}}

# {{{ Specific to local setups

sh_load_status 'local hooks'

run_hooks .zsh/rc.d

# }}}

# {{{ Profiling report

if [[ -n "$ZSHRC_PROFILE_RC" ]]; then
    zprof >! ~/zshrc.zprof
    exit
fi

# }}}

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0:
