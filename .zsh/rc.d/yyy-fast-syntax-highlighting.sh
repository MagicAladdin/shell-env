# $Id: ~/.zsh/rc.d/yyy-fast-syntax-highlighting.sh wandsas 2018/08/09

# Zsh fast syntax highlighting
# https://github.com/zdharma/fast-syntax-highlighting/
#
# Set colors according to a 256 color scheme if supported.


# Hash holding paths that shouldn't be grepped (globbed)
typeset -gA FAST_BLIST_PATTERNS
FAST_BLIST_PATTERNS[/public/*]=1

# Async path checking
# useful on slow networks, or when there are many files in a directory.
#FAST_HIGHLIGHT[use_async]=1

zshrc_fast_syntax_highlighting() {
	(($+FAST_HIGHLIGHT_STYLES)) || path=(
		${DEFAULTS:+${^DEFAULTS%/}{,/zsh}{/fast-syntax-highlighting,}}
		${GITS:+${^GITS%/}{/fast-syntax-highlighting{.git,},}}
		${EXPREFIX:+${^EPREFIX%/}/usr/share/zsh/site-contrib{/fast-syntax-highlighting,}}
		/usr/share/zsh/site-contrib{/fast-syntax-highlighting,}
		$path
	) . fast-syntax-highlighting.plugin.zsh NIL || return
	:
}

zshrc_highlight_styles() {
	local -a brackets
	local -A styles
	local i
	if [[ $(echotc Co) -ge 256 ]]
	then	brackets=(
			fg=98,bold
			fg=135,bold
			fg=141,bold
			fg=147,bold
			fg=153,bold
		)
		styles=(
			'default'                       fg=252
			'unknown-token'                 fg=64,bold
			'reserved-word'                 fg=84,bold
			'alias'                         fg=118,bold
			'builtin'                       fg=47,bold
			'function'                      fg=76,bold
			'command'                       fg=40,bold
			'precommand'                    fg=40,bold
			'hashed-command'                fg=40,bold
			'path'                          fg=214,bold
			'path_prefix'                   fg=202,bold
			'path_approx'                   fg=202,bold
			'globbing'                      fg=190,bold
			'history-expansion'             fg=166,bold
			'single-hyphen-option'          fg=33,bold
			'double-hyphen-option'          fg=45,bold
			'back-quoted-argument'          fg=202
			'single-quoted-argument'        fg=181,bold
			'double-quoted-argument'        fg=181,bold
			'dollar-double-quoted-argument' fg=196
			'back-double-quoted-argument'   fg=202
			'assign'                        fg=159,bold
			'bracket-error'                 fg=196,bold
			'back-or-dollar-double-quoted-argument' fg=196
			'assign-array-bracket'          fg=147,bold
			'back-dollar-quoted-argument'   fg=181,bold
			'commandseparator'              fg=69,bold
			'comment'                       fg=177,bold
			'dollar-quoted-argument'        fg=196
			'for-loop-number'               fg=140
			'for-loop-operator'             fg=31,bold
			'for-loop-separator'            fg=99,bold
			'for-loop-variable'             fg=208
			'here-string-tri'               fg=190
			'here-string-word'              fg=225
			'matherr'                       fg=196,bold
			'mathnum'                       fg=140
			'mathvar'                       fg=208
			'path_pathseparator'            fg=207
			'redirection'                   fg=123,bold
			'suffix-alias'                  fg=84,bold
			'variable'                      fg=208
		)
		case ${SOLARIZED:-n} in
		([nNfF]*|[oO][fF]*|0|-)
			false;;
		esac && styles+=(
			'unknown-token'                 fg=red,bold
			'reserved-word'                 fg=white
			'alias'                         fg=cyan,bold
			'builtin'                       fg=yellow,bold
			'function'                      fg=blue,bold
			'command'                       fg=green
			'precommand'                    fg=green
			'hashed-command'                fg=green
			'path'                          fg=yellow
			'path_prefix'                   fg=yellow
			'globbing'                      fg=magenta
			'single-hyphen-option'          fg=green,bold
			'double-hyphen-option'          fg=magenta,bold
			'assign'                        fg=cyan
			'bracket-error'                 fg=red
		)
	else	brackets=(
			fg=cyan
			fg=magenta
			fg=blue,bold
			fg=red
			fg=green
		)
		styles=(
			'default'                       none
			'unknown-token'                 fg=red,bold
			'reserved-word'                 fg=green,bold
			'alias'                         fg=green,bold
			'builtin'                       fg=green,bold
			'function'                      fg=green,bold
			'command'                       fg=yellow,bold
			'precommand'                    fg=yellow,bold
			'hashed-command'                fg=yellow,bold
			'path'                          fg=white,bold
			'path_prefix'                   fg=white,bold
			'path_approx'                   none
			'globbing'                      fg=magenta,bold
			'history-expansion'             fg=yellow,bold,bg=red
			'single-hyphen-option'          fg=cyan,bold
			'double-hyphen-option'          fg=cyan,bold
			'back-quoted-argument'          fg=yellow,bg=blue
			'single-quoted-argument'        fg=yellow
			'double-quoted-argument'        fg=yellow
			'dollar-double-quoted-argument' fg=yellow,bg=blue
			'back-double-quoted-argument'   fg=yellow,bg=blue
			'assign'                        fg=yellow,bold,bg=blue
			'bracket-error'                 fg=red,bold
			'back-or-dollar-double-quoted-argument' fg=yellow,bg=blue
			'assign-array-bracket'          fg=green
			'back-dollar-quoted-argument'   fg=yellow,bold,bg=blue
			'commandseparator'              fg=blue,bold
			'comment'                       fg=black,bold
			'dollar-quoted-argument'        fg=yellow,bg=blue
			'for-loop-number'               fg=magenta
			'for-loop-operator'             fg=yellow
			'for-loop-separator'            fg=blue,bold
			'for-loop-variable'             fg=yellow,bold
			'here-string-tri'               fg=yellow
			'here-string-word'              bg=blue
			'matherr'                       fg=red
			'mathnum'                       fg=magenta
			'mathvar'                       fg=blue,bold
			'path_pathseparator'            fg=white,bold
			'redirection'                   fg=blue,bold
			'suffix-alias'                  fg=green
			'variable'                      fg=yellow,bold
		)
	fi
	for i in {1..5}
	do	styles[bracket-level-$i]=${brackets[$i]}
	done
	typeset -gA $1
	eval $1+=(\${(kv)styles})
	if [ $# -ge 2 ]
	then	typeset -ga $2
		set -A $2 $brackets
	fi
}

if [[ -z "${ZSHRC_SKIP_HIGHLIGHTING:++}" ]] && is-at-least 4.3.9
then  zshrc_fast_syntax_highlighting
fi

#
# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
if [[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]]
then    unfunction zshrc_highlight_styles zshrc_fast_syntax_highlighting
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0
