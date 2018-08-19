
:	${COLUMNS:=80}

# @FUNCTION: Yes or No helper
yesno() {
	case "${1:-NO}" in
	(0|[Dd][Ii][Ss][Aa][Bb][Ll][Ee]|[Oo][Ff][Ff]|[Ff][Aa][Ll][Ss][Ee]|[Nn][Oo])
		return 1;;
	(1|[Ee][Nn][Aa][Bb][Ll][Ee]|[Oo][Nn]|[Tt][Rr][Uu][Ee]|[Yy][Ee][Ss])
		return 0;;
	(*)
		return 2;;
	esac
}

# @FUNCTION: Print begin message to stdout
# @ARG: <msg>
begin() {
	local _msg="$*"
	printf "$print_eol"
	print_eol="\n"
	print_len=$((${#msg}+8+${#name}))

	local prefix="${name:+$color_fg_mag[$color_fg_blu$name$color_fg_mag]$color_rst}"
	printf "$prefix $@"
}

# @FUNCTION: Print end message to stdout
# @ARG: <ret> [<msg>]
end() {
	local ret="$1" suffix
	case "$1" in
		(0) suffix="$color_fg_blu[${color_fg_grn}ok$color_fg_blu]$color_rst";;
		(*) suffix="$color_fg_ylw[${color_fg_red}no$color_fg_ylw]$color_rst";;
	esac
	shift
	print_len=$(($COLUMNS-$print_len))
	printf "%${print_len}s" "$*"
	printf "$suffix\n"
	print_eol=
	print_len=0
	return "$ret"
}

# @FUNCTION: Colors handler
eval_colors() {
	[ -t 1 ] && yesno "${COLOR:-Yes}" || return

	local b='4' e='\e[' f='3' c
	for c in 0:blk 1:red 2:grn 3:ylw 4:blu 5:mag 6:cyn 7:wht; do
		eval color_bg_${c#*:}="'${e}1;${b}${c%:*}m'"
		eval color_fg_${c#*:}="'${e}1;${f}${c%:*}m'"
		eval color_bg_${c%:*}="'${e}${b}${c%:*}m'"
		eval color_fg_${c%:*}="'${e}${f}${c%:*}m'"
	done
	color_rst="${e}0m"
	color_bld="${e}1m"
	color_und="${e}4m"
	color_ita="${e}3m"
}

# @FUNCTION: Print message to stdout
# @ARG: <msg>
info() {
	local prefix="${name:+$color_fg_mag$name:$color_rst}"
	printf "$print_eol${color_fg_blu}INFO: $prefix $@\n"
}

# @FUNCTION: Print warn message to stdout
# @ARG: <msg>
warn() {
	local prefix="${name:+$color_fg_red$name:$color_rst}"
	printf "$print_eol${color_fg_ylw}WARN: $prefix $@\n"
}

# @FUNCTION: Print message to stderr
# @ARG: <msg>
error() {
	local prefix="${name:+$color_fg_ylw$name:$color_rst}"
	printf "$print_eol${color_fg_red}ERROR: $prefix $@\n" >&2
}

# @DESCRIPTION: Handle scripts fatal error
# @ARG: <msg>
die() {
	local ret=$?
	[ -n "$@" ] && error "$@"
	exit $ret
}

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:ts=4:et:
