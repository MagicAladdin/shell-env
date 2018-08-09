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

if [[ -z "${ZSHRC_SKIP_AUTOSUGGESTIONS:++}" ]]
then    zshrc_autosuggestions
fi

# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
if [[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]]
then    unfunction zshrc_bindkey zshrc_autosuggestions
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:fdm=marker:foldlevel=0
