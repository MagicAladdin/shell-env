#
# Zsh key-bindings
#

# Return if requirements are not available
if [[ "${TERM}" == dumb ]] { return }

# vi-mode key-bindings
bindkey -v

# custom zle widgets
function jump_after_first_word () {
    local words
    words=(${(z)BUFFER})

    if (( ${#words} <= 1 )) ; then
        CURSOR=${#BUFFER}
    else
        CURSOR=${#${words[1]}}
    fi
}
zle -N jump_after_first_word

function peco_select_history() {
    local tac
    ((($+commands[gtac])) && tac="gtac") || \
      (($+commands[tac])) && tac="tac" || \
      tac="tail -r"
    BUFFER=$(fc -l -n 1 | eval $tac | \
        peco --layout=bottom-up --query "$LBUFFER")
    CURSOR=$#BUFFER     # move cursor
    zle -R -c           # refresh
}
zle -N peco_select_history
bindkey '^h' peco_select_history

# press "ctrl+z" to add sudo before existing command
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line
bindkey '^z' sudo-command-line

#bindkey '^g' list ghq src
function peco-ghq () {
    local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq
bindkey '^g' peco-ghq

# press "ctrl-x d" to insert the actual date in the form yyyy-mm-dd
function insert-datestamp () { LBUFFER+=${(%):-'%D{%Y-%m-%d}'}; }
zle -N insert-datestamp


#
# ZLE-widget my-extended-wordchars
#

my_extended_wordchars='*?_-.[]~=&;!#$%^(){}<>:@,\\';
my_extended_wordchars_space="${my_extended_wordchars} "
my_extended_wordchars_slash="${my_extended_wordchars}/"

# is the current position \-quoted ?
function is_quoted(){
 test "${BUFFER[$CURSOR-1,CURSOR-1]}" = "\\"
}

unquote-forward-word(){
    while is_quoted
      do zle .forward-word
    done
}

unquote-backward-word(){
    while  is_quoted
      do zle .backward-word
    done
}

backward-to-space() {
    local WORDCHARS=${my_extended_wordchars_slash}
    zle .backward-word
    unquote-backward-word
}

forward-to-space() {
     local WORDCHARS=${my_extended_wordchars_slash}
     zle .forward-word
     unquote-forward-word
}

backward-to-/ () {
    local WORDCHARS=${my_extended_wordchars}
    zle .backward-word
    unquote-backward-word
}

forward-to-/ () {
     local WORDCHARS=${my_extended_wordchars}
     zle .forward-word
     unquote-forward-word
}

zle -N backward-to-space
zle -N forward-to-space
zle -N backward-to-/
zle -N forward-to-/

bindkey "^[B" backward-to-space
bindkey "^[F" forward-to-space
bindkey "^[^b" backward-to-/
bindkey "^[^f" forward-to-/

#
# Helper functions for key-bindings
#

function zrcgotwidget () {
    (( ${+widgets[$1]} ))
}

function zrcgotkeymap () {
    [[ -n ${(M)keymaps:#$1} ]]
}

autoload insert-files && zle -N insert-files
autoload edit-command-line && zle -N edit-command-line
autoload insert-unicode-char && zle -N insert-unicode-char
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end  history-search-end
zle -C hist-complete complete-word _generic
zstyle ':completion:hist-complete:*' completer _history


#
# The actual terminal setup hooks and bindkey-calls
#

function zrcbindkey () {
    if (( ARGC )) && zrcgotwidget ${argv[-1]}; then
        bindkey "$@"
    fi
}

function bind2maps () {
    local i sequence widget
    local -a maps

    while [[ "$1" != "--" ]]; do
        maps+=( "$1" )
        shift
    done
    shift

    if [[ "$1" == "-s" ]]; then
        shift
        sequence="$1"
    else
        sequence="${key[$1]}"
    fi
    widget="$2"

    [[ -z "$sequence" ]] && return 1

    for i in "${maps[@]}"; do
        zrcbindkey -M "$i" "$sequence" "$widget"
    done
}

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-smkx () {
        emulate -L zsh
        printf '%s' ${terminfo[smkx]}
    }
    function zle-rmkx () {
        emulate -L zsh
        printf '%s' ${terminfo[rmkx]}
    }
    function zle-line-init () {
        zle-smkx
    }
    function zle-line-finish () {
        zle-rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
else
    for i in {s,r}mkx; do
        (( ${+terminfo[$i]} ))
    done
    unset i
fi

typeset -A key
key=(
    Home        "${terminfo[khome]}"
    End         "${terminfo[kend]}"
    Insert      "${terminfo[kich1]}"
    Delete      "${terminfo[kdch1]}"
    Up          "${terminfo[kcuu1]}"
    Down        "${terminfo[kcud1]}"
    Left        "${terminfo[kcub1]}"
    Right       "${terminfo[kcuf1]}"
    PageUp      "${terminfo[kpp]}"
    PageDown    "${terminfo[knp]}"
    BackTab     "${terminfo[kcbt]}"
)


bind2maps emacs             -- Home   beginning-of-somewhere
bind2maps       viins vicmd -- Home   vi-beginning-of-line
bind2maps emacs             -- End    end-of-somewhere
bind2maps       viins vicmd -- End    vi-end-of-line
bind2maps emacs viins       -- Insert overwrite-mode
bind2maps             vicmd -- Insert vi-insert
bind2maps emacs             -- Delete delete-char
bind2maps       viins vicmd -- Delete vi-delete-char
bind2maps emacs viins vicmd -- Up     up-line-or-search
bind2maps emacs viins vicmd -- Down   down-line-or-search
bind2maps emacs             -- Left   backward-char
bind2maps       viins vicmd -- Left   vi-backward-char
bind2maps emacs             -- Right  forward-char
bind2maps       viins vicmd -- Right  vi-forward-char

# Insert files and test globbing
bind2maps emacs viins       -- -s "^xf" insert-files
# Edit the current line in $EDITOR
bind2maps emacs viins       -- -s '\ee' edit-command-line
# search history backward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xp' history-beginning-search-backward-end
# search history forward for entry beginning with typed text
bind2maps emacs viins       -- -s '^xP' history-beginning-search-forward-end
# search history backward for entry beginning with typed text
bind2maps emacs viins       -- PageUp history-beginning-search-backward-end
# search history forward for entry beginning with typed text
bind2maps emacs viins       -- PageDown history-beginning-search-forward-end
bind2maps emacs viins       -- -s "^x^h" commit-to-history
# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\ev' slash-backward-kill-word
# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\e^h' slash-backward-kill-word
# Kill left-side word or everything up to next slash
bind2maps emacs viins       -- -s '\e^?' slash-backward-kill-word
# Do history expansion on space:
bind2maps emacs viins       -- -s ' ' magic-space
# Trigger menu-complete
bind2maps emacs viins       -- -s '\ei' menu-complete  # menu completion via esc-i
# Insert a timestamp on the command line (yyyy-mm-dd)
bind2maps emacs viins       -- -s '^xd' insert-datestamp
# prepend the current command with "sudo"
bind2maps emacs viins       -- -s "^z" sudo-command-line
# jump to after first word (for adding options)
bind2maps emacs viins       -- -s '^x1' jump_after_first_word
# complete word from history with menu
bind2maps emacs viins       -- -s "^x^x" hist-complete

# insert unicode character
# usage example: 'ctrl-x i' 00A7 'ctrl-x i' will give you an §
# See for example http://unicode.org/charts/ for unicode characters code
# Insert Unicode character
bind2maps emacs viins       -- -s '^xi' insert-unicode-char

# use the new *-pattern-* widgets for incremental history search
if zrcgotwidget history-incremental-pattern-search-backward; then
    for seq wid in '^r' history-incremental-pattern-search-backward \
                   '^s' history-incremental-pattern-search-forward
    do
        bind2maps emacs viins vicmd -- -s $seq $wid
    done
    builtin unset -v seq wid
fi

if zrcgotkeymap menuselect; then
    # k Shift-tab Perform backwards menu completion
    bind2maps menuselect -- BackTab reverse-menu-complete

    # menu selection: pick item but stay in the menu
    bind2maps menuselect -- -s '\e^M' accept-and-menu-complete
    # also use + and INSERT since it's easier to press repeatedly
    bind2maps menuselect -- -s '+' accept-and-menu-complete
    bind2maps menuselect -- Insert accept-and-menu-complete

    # accept a completion and try to complete again by using menu
    # completion; very useful with completing directories
    # by using 'undo' one's got a simple file browser
    bind2maps menuselect -- -s '^o' accept-and-infer-next-history
fi

# Finally, here are still a few hardcoded escape sequences; Special sequences
# like Ctrl-<Cursor-key> etc do suck a fair bit, because they are not
# standardised and most of the time are not available in a terminals terminfo
# entry.
#
# While we do not encourage adding bindings like these, we will keep these for
# backward compatibility.

## use Ctrl-left-arrow and Ctrl-right-arrow for jumping to word-beginnings on
## the command line.

# URxvt
bind2maps emacs viins vicmd -- -s '\eOc' forward-word
bind2maps emacs viins vicmd -- -s '\eOd' backward-word
# xterm
bind2maps emacs viins vicmd -- -s '\e[1;5C' forward-word
bind2maps emacs viins vicmd -- -s '\e[1;5D' backward-word
## the same for alt-left-arrow and alt-right-arrow
# URxvt
bind2maps emacs viins vicmd -- -s '\e\e[C' forward-word
bind2maps emacs viins vicmd -- -s '\e\e[D' backward-word
# Xterm
bind2maps emacs viins vicmd -- -s '^[[1;3C' forward-word
bind2maps emacs viins vicmd -- -s '^[[1;3D' backward-word
# Also try ESC Left/Right:
bind2maps emacs viins vicmd -- -s '\e'${key[Right]} forward-word
bind2maps emacs viins vicmd -- -s '\e'${key[Left]}  backward-word

# vim:fenc=utf-8:ft=zsh:
