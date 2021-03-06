
:	${COLUMNS:=80}

die () {
    local ret="$?"
	printf '\033[1;31mERROR\033[0m %s\n' "$@" >&2
	exit "$?"
}

info () {
	printf '\n\033[1;36mINFO\033[0m %s\n' "$@" >&2
}

warn () {
	printf '\033[1;33mWARN\033[0m %s\n' "$@" >&2
}

debug () {
    [[ -n "$DEBUG" ]] && einfo "$@"
}

# vim:fenc=utf-8:ft=sh:
