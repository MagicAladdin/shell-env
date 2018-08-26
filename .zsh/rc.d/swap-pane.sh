autoload -U add-zsh-hook

if [ "$TMUX" ]; then
    function _set-pane-name() {
        local max_cmd_length=20
        local cmd="$1"
        if [ $#cmd -gt $max_cmd_length ]; then
            cmd="${cmd:0:$max_cmd_length}..."
        fi
        printf "\033]2;${PWD/$HOME/~}: $cmd\033\\"
    }

    add-zsh-hook preexec _set-pane-name
    add-zsh-hook precmd _set-pane-name
fi

# vim:fenc=utf-8:ft=sh:
