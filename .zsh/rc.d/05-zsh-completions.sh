# $Id: ~/.zsh/rc.d/05-zsh-completions.sh wandsas 2018/08/09
#
# Zsh Completion system
#

# use 'zstyle' for getting current settings:
# press ^xh (control-x h) for getting tags in context
#       ^x? (control-x ?) to run complete_debug with trace output


[[ "${TERM}" == dumb ]] && return


# Initialize the completion system ignoring insecure directories:
# compinit -i -d $ZDOTDIR/.zsh/zcompdump

autoload -U complist
autoload -U compinit && compinit


#
# Completion options
#

setopt COMPLETE_IN_WORD     # complete from both ends of a word
setopt ALWAYS_TO_END        # move cursor to the end of a completed word
setopt PATH_DIRS            # perform path search even on command names with slashes
setopt AUTO_MENU            # show completion menu on a successive tab press
setopt AUTO_LIST            # automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH     # if completed parameter is a directory, add a trailing slash
setopt NO_MENU_COMPLETE     # do not autoselect the first completion entry
setopt NO_FLOW_CONTROL      # disable start/stop characters in shell editor
setopt CORRECT              # smart completion correction

# Completion caching
zstyle ':completion:*'              use-cache  yes
zstyle ':completion:*:complete:*'   cache-path ${ZDOTDIR:-${HOME}/.cache}

# allow one error for every three characters typed in approximate completer
zstyle ':completion:*:approximate:'     max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

# don't complete backup files (e.g. bin/foo~) as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(*\~)'

# Don't complete uninteresting users...
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

# start menu completion only if it could find no unambiguous initial string
zstyle ':completion:*:correct:*'        insert-unambiguous true
#zstyle ':completion:*:corrections'      format $'%{\e[0;31m%}%d (errors: %e)m%{g\e[0m%}'
zstyle ':completion:*:corrections'      format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:correct:*'        original true

# activate color-completion
zstyle ':completion:*:default'          list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*'           tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*'        group-order 'named-directories' 'path-directories' 'expand'
zstyle ':completion:*'                  squeeze-slashes true

# format on completion
zstyle ':completion:*:descriptions'     format ' %F{yellow}-- %d --%f'

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

# separate matches into groups
zstyle ':completion:*:matches'          group 'yes'
zstyle ':completion:*'                  group-name ''

# if there are more than 5 options allow selecting from a menu
zstyle ':completion:*:*:*:*:*'          menu select

zstyle ':completion:*:messages'         format ' %F{purple} -- %d --%f'
zstyle ':completion:*:descriptions'     format ' %F{yellow}-- %d% --%f'
zstyle ':completion:*:warnings'         format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default'          list-prompt '%S%M matches%s'
zstyle ':completion:*'                  format ' %F{yellow}-- %d --%f'

# describe options in full
zstyle ':completion:*:options'          description 'yes'
zstyle ':completion:*:options'          auto-description '%d'

# Activate color-completion
zstyle ':completion:*:default'          list-colors ${(s.:.)LS_COLORS}

# Completion for processes
zstyle ':completion:*:*:*:*:processes'  menu yes select
zstyle ':completion:*:*:*:*:processes'  force-list always
zstyle ':completion:*:*:*:*:processes'  command 'ps -u $LOGNAME -o pid,user,command -w'

zstyle ':completion:*:processes-names'  command 'ps c -u ${USER} -o command | uniq'

zstyle ':completion:*:*:kill:*'         menu yes select
zstyle ':completion:*:*:kill:*'         force-list always
zstyle ':completion:*:*:kill:*'         insert-ids single

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'

zstyle ':completion:*:kill:*'           force-list always
zstyle ':completion:*:processes'        command "ps -eo pid,user,comm,cmd -w -w"

zstyle ':completion:*:*:killall:*'      menu yes select
zstyle ':completion:*:killall:*'        force-list always

# Array/association subscripts
# When completing inside array or association subscripts, the array elements
# are more useful than parameters so complete them first
zstyle ':completion:*:*:-subscript-:*'  tag-order indexes parameters

# provide verbose completion information
zstyle ':completion:*'                  verbose true

# recent (as of Dec 2007) zsh versions are able to provide descriptions
# for commands (read: 1st word in the line) that it will list for the user
# to choose from. The following disables that, because it's not exactly fast.
zstyle ':completion:*:-command-:*:'     verbose false

# define files to ignore for zcompile
zstyle ':completion:*:*:zcompile:*'     ignored-patterns '(*~|*.zwc)'
zstyle ':completion:correct:'           prompt 'correct to: %e'

# Ignore completion functions for commands you don't have:
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '(_*|pre(cmd|exec)|prompt_*)'

# Man
zstyle ':completion:*:manuals'          separate-sections true
zstyle ':completion:*:manuals.(^1*)'    insert-sections true

# Search path for sudo completion
zstyle ':completion:*:sudo:*' command-path  /root \
                                            /usr/local/{bin,sbin} \
                                            /usr/{bin,sbin} \
                                            /{bin,sbin}

# provide .. as a completion
zstyle ':completion:*' special-dirs ..

# run rehash on completion so new installed program are found automatically:
function _force_rehash () {
    (( CURRENT == 1 )) && rehash
    return 1
}


#
# Smart completion correction
#

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

# Host completion
[[ -r ~/.ssh/config ]] && _ssh_config_hosts=(${${(s: :)${(ps:\t:)${${(@M)${(f)"$(<$HOME/.ssh/config)"}:#Host *}#Host }}}:#*[*?]*}) || _ssh_config_hosts=()
[[ -r ~/.ssh/known_hosts ]] && _ssh_hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[\|]*}%%\ *}%%,*}) || _ssh_hosts=()
[[ -r /etc/hosts ]] && : ${(A)_etc_hosts:=${(s: :)${(ps:\t:)${${(f)~~"$(</etc/hosts)"}%%\#*}##[:blank:]#[^[:blank:]]#}}} || _etc_hosts=()

hosts=(
    $(hostname)
    "$_ssh_config_hosts[@]"
    "$_ssh_hosts[@]"
    "$_etc_hosts[@]"
    localhost
)
zstyle ':completion:*:hosts' hosts $hosts


#
# GNU generic works with commands that provide standard --help options
#

for compcom in cp df feh gpasswd head mv pal stow uname; do
    [[ -z ${_comps[$compcom]} ]] && compdef _gnu_generic ${compcom}
done;

unset compcom

# vim:fenc=utf-8:ft=zsh:
