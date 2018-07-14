#
# Zsh Morpho screen savers
#
# https://github.com/psprint/zsh-morpho/

#zstyle ":morpho" screen-saver "zmandelbrot"
#zstyle ":morpho" arguments "-s"
#zstyle ":morpho" delay "290"
#zstyle ":morpho" arguments "-s"
#zstyle ":morpho" delay "290"
#zstyle ":morpho" check-interval "60"

#morpho="/usr/share/zsh/site-contib/zsh-morpho"

#[[ -r "$morpho/zsh-morpho.plugin.zsh" ]] && {
#    source $morpo/zsh-morpho.plugin.zsh
#}

# History search multi word
# https://github.com/zdharma/fast/syntax-highlighting/

#zstyle ":history-search-multi-word" page-size "5"
#zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes"

#hsmw="/usr/share/zsh/site-contrib/history-search-multi-word"

#[[ -r "$hsmw/history-search-multi-word.plugin.zsh" ]] && {
#    source $hsmw/history-search-multi-word.plugin.zsh
#}

# Wrapper function for bindkey: multiple keys, $'$...' refers to terminfo;
# - means -M menuselect

zshrc_bindkey() {
	local b c
	local -a a
	if [[ ${1-} == - ]]
	then	a=(-M menuselect)
		shift
	else	a=()
	fi
	b=$1
	shift
	while [[ $# -gt 0 ]]
	do	case $1 in
		(*[^-a-zA-Z0-9_]*)
			[[ -z ${key[(re)$1]:++} ]] && c=$1 || c=;;
		(*)
			c=${key[$1]};;
		esac
		[[ -z $c ]] || bindkey $a $c $b
		shift
	done
}

# Activate syntax highlighting
# https://github.com/zdharma/fast-syntax-highlighting/
#
# Set colors according to a 256 color scheme if supported.

zshrc_fast_syntax_highlighting() {
	(($+FAST_HIGHLIGHT_STYLES)) || path=(
		${DEFAULTS:+${^DEFAULTS%/}{,/zsh}{/fast-syntax-highlighting,}}
		${GITS:+${^GITS%/}{/fast-syntax-highlighting{.git,},}}
		${EXPREFIX:+${^EPREFIX%/}/usr/share/zsh/site-contrib{/fast-syntax-highlighting,}}
		/usr/share/zsh/site-contrib{/fast-syntax-highlighting,}
		$path
	) . fast-syntax-highlighting.plugin.zsh NIL || return
	#zshrc_highlight_styles FAST_HIGHLIGHT_STYLES
	:
}
zshrc_zsh_syntax_highlighting() {
	(($+ZSH_HIGHLIGHT_HIGHLIGHTERS)) || path=(
		${DEFAULTS:+${^DEFAULTS%/}{,/zsh}{/zsh-syntax-highlighting,}}
		${GITS:+${^GITS%/}{/zsh-syntax-highlighting{.git,},}}
		${EXPREFIX:+${^EPREFIX%/}/usr/share/zsh/site-contrib{/zsh-syntax-highlighting,}}
		/usr/share/zsh/site-contrib{/zsh-syntax-highlighting,}
		$path
	) . zsh-syntax-highlighting.zsh NIL || return
	typeset -gUa ZSH_HIGHLIGHT_HIGHLIGHTERS
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(
		main		# color syntax while typing (active by default)
#		patterns	# color according to ZSH_HIGHLIGHT_PATTERNS
		brackets	# color matching () {} [] pairs
#		cursor		# color cursor; useless with cursorColor
#		root		# color if you are root; broken in some versions
	)
	zshrc_highlight_styles \
		ZSH_HIGHLIGHT_STYLES ZSH_HIGHLIGHT_MATCHING_BRACKETS_STYLES
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

if [[ -z "${ZSHRC_SKIP_SYNTAX_HIGHLIGHTING:++}" ]] && is-at-least 4.3.9
then	if [[ -n "${ZSHRC_PREFER_ZSH_SYNTAX_HIGHLIGHTING:++}" ]]
	then	zshrc_zsh_syntax_highlighting || zshrc_fast_syntax_highlighting
	else	zshrc_fast_syntax_highlighting || zshrc_zsh_syntax_highlighting
	fi
fi

# Activate autosuggestions and/or incremental completion from one of
# https://github.com/zsh-users/zsh-autosuggestions/
#   (at the time of writing this, branch develop supports completion)
# https://github.com/hchbaw/auto-fu.zsh/
#   (only branch pu works with {fast,zsh}-syntax-highlighting)
# (prefer the latter if ZSHRC_PREFER_AUTO_FU is nonempty;
# otherwise use both only if ZSHRC_USE_AUTO_FU is nonempty
# skip both if ZSHRC_SKIP_AUTO is nonempty.)

zshrc_autosuggestions() {
	is-at-least 4.3.11 || return
	(($+ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE)) || \
	path=(${DEFAULTS:+${^DEFAULTS%/}{,/zsh}{/zsh-autosuggestions,}}
		${GITS:+${^GITS%/}{/zsh-autosuggestions{.git,},}}
		${EXPREFIX:+${^EPREFIX%/}/usr/share/zsh/site-contrib{/zsh-autosuggestions,}}
		/usr/share/zsh/site-contrib{/zsh-autosuggestions,}
		$path) . zsh-autosuggestions.zsh NIL || return
	if [[ $(echotc Co) -ge 256 ]]
	then	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=99,bold,bg=18'
	else	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold,bg=magenta'
	fi
	typeset -g ZSH_AUTOSUGGEST_USE_ASYNC=true
	typeset -gUa  ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS \
		ZSH_AUTOSUGGEST_ACCEPT_WIDGETS ZSH_AUTOSUGGEST_EXECUTE_WIDGETS \
		ZSH_AUTOSUGGEST_CLEAR_WIDGETS
	typeset -ga ZSH_AUTOSUGGEST_STRATEGY
	ZSH_AUTOSUGGEST_STRATEGY=(completion history)
	ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(${(@)ZSH_AUTOSUGGEST_ACCEPT_WIDGETS:#*forward-char})
	ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(forward-char vi-forward-char)
	autosuggest-self-insert-clear() {
		zle self-insert
		_zsh_autosuggest_clear
	}
	zle -N autosuggest-self-insert-clear
	zshrc_bindkey autosuggest-self-insert-clear "#"
	if [[ -z "${ZSHRC_AUTO_ACCEPT:++}" ]]
	then	if [[ $(echotc Co) -ge 256 ]]
		then	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=136,bg=235'
		else	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold,bg=magenta'
		fi
	else	if [[ $(echotc Co) -ge 256 ]]
		then	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=99,bold'
		else	ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=246,bold'
		fi
		zle -N autosuggest-accept-line _zsh_autosuggest_execute
		zshrc_bindkey autosuggest-accept-line "^M"
	fi
}

zshrc_auto_fu_load() {
	: # Status must be 0 before sourcing auto-fu.zsh
	. auto-fu NIL && auto-fu-install && return
	:
	. auto-fu.zsh NIL
}
zshrc_auto_fu() {
	(($+functions[auto-fu-init])) || path=(
		${DEFAULTS:+${^DEFAULTS%/}{,/zsh}{/auto-fu{.zsh,},}}
		${GITS:+${^GITS%/}{/auto-fu{.zsh,}{.git,},}}
		${EPREFIX:+${^EPREFIX%/}/usr/share/zsh/site-contrib{/auto-fu{.zsh,},}}
		/usr/share/zsh/site-contrib{/auto-fu{.zsh,},}
		$path
	) zshrc_auto_fu_load || return
	unset ZSHRC_AUTO_ACCEPT
	# auto-fu.zsh gives confusing messages with warn_create_global:
	setopt no_warn_create_global
	# Keep Ctrl-d behavior also when auto-fu is active
	afu+orf-ignoreeof-deletechar-list() {
	afu-eof-maybe afu-ignore-eof zle kill-line-maybe
}
	afu+orf-exit-deletechar-list() {
	afu-eof-maybe exit zle kill-line-maybe
}
	zstyle ':auto-fu:highlight' input
	zstyle ':auto-fu:highlight' completion fg=yellow
	zstyle ':auto-fu:highlight' completion/one fg=green
	zstyle ':auto-fu:var' postdisplay # $'\n-azfu-'
	zstyle ':auto-fu:var' track-keymap-skip opp
	zstyle ':auto-fu:var' enable all
	zstyle ':auto-fu:var' disable magic-space
	if (($+functions[init-transmit-mode]))
	then	zle-line-init() {
	init-transmit-mode
	auto-fu-init
}
		zle -N zle-line-init
	else	zle -N zle-line-init auto-fu-init
	fi
	zle -N zle-keymap-select auto-fu-zle-keymap-select
	zstyle ':completion:*' completer _complete

	# Starting a line with a space or tab or quoting the first word
	# or escaping a word should deactivate auto-fu for that line/word.
	# This is useful e.g. if auto-fu is too slow for you in some cases.
	zstyle ':auto-fu:var' autoable-function/skiplines '[[:blank:]\\"'\'']*'
	zstyle ':auto-fu:var' autoable-function/skipwords '[\\]*'

	# Unfortunately, auto-fu is always too slow for portage or eix.
	# Therefore, we disable package completion with auto-fu:
	zstyle ':completion:*:*:eix*:*' tag-order options dummy - '!packages'
	zstyle ':completion:*:*:emerge:argument-rest*' tag-order values available_sets -
}

if [[ -z "${ZSHRC_SKIP_AUTO:++}" ]]
then	if [[ -n "${ZSHRC_PREFER_AUTO_FU:++}" ]]
	then	zshrc_auto_fu || zshrc_autosuggestions
	elif [[ -z "${ZSHRC_USE_AUTO_FU}" ]]
	then	zshrc_autosuggestions || zshrc_auto_fu
	else	zshrc_auto_fu
		zshrc_autosuggestions
	fi
fi

# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
[[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]] || unfunction \
	zshrc_bindkey zshrc_highlight_styles \
	zshrc_fast_syntax_highlighting zshrc_autosuggestions

# vim:fenc=utf-8:ft=zsh:
