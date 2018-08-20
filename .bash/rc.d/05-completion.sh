#
# Bash completion
#

[[ "$TERM" == dumb ]] && return

# Disable completion when the input buffer is empty (e.g. pressing tab and
# waiting a long time for bash to expand the whole PATH).
shopt -s no_empty_cmd_completion


# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}"]; then
    _passred(){
        PASSWORD_STORE_DIR=~/.pass/red/ _pass
    }
    complete -o filenames -o nospace -F _passred passred

    _passblue(){
        PASSWORD_STORE_DIR=~/.pass/blue/ _pass
    }
    complete -o filenames -o nospace -F _passblue passblue

fi

# vim:fenc=utf-8:ft=sh:
