
if which emacs >/dev/null 2>&1; then
    e () {
        emacs "$@" 2>&1 &
    }
fi
