
die () {
    local ret="$?"
	printf '\033[1;31mERROR:\033[0m %s\n' "$@" >&2
	exit "$?"
}

einfo () {
	printf '\n\033[1;36m> \033[0m %s\n' "$@" >&2
}

ewarn () {
	printf '\033[1;33m> \033[0m %s\n' "$@" >&2
}

debug () {
    [[ -n "$DEBUG" ]] && einfo "$@"
}

# vim:fenc=utf-8:ft=sh:
