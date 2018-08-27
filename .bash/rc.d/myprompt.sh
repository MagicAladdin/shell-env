# $Id: ~/.bash/rc.d/my-bash-prompt.sh wandsas 2018/08/09
#
# My extravagant bash prompt
#

parse_git_dirty () {
    [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
}

parse_git_branch () {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

my_extravagant_bash_prompt () {
    if tput setaf 1 &> /dev/null; then
        tput sgr0
        if [[ $(tput colors) -ge 256 ]] 2>/dev/null; then
          MAGENTA=$(tput setaf 9)
          ORANGE=$(tput setaf 172)
          GREEN=$(tput setaf 190)
          PURPLE=$(tput setaf 141)
          WHITE=$(tput setaf 256)
        else
          MAGENTA=$(tput setaf 5)
          ORANGE=$(tput setaf 4)
          GREEN=$(tput setaf 2)
          PURPLE=$(tput setaf 1)
          WHITE=$(tput setaf 7)
        fi
        BOLD=$(tput bold)
        RESET=$(tput sgr0)
    else
        MAGENTA="\033[1;31m"
        ORANGE="\033[1;33m"
        GREEN="\033[1;32m"
        PURPLE="\033[1;35m"
        WHITE="\033[1;37m"
        BOLD=""
        RESET="\033[m"
    fi

    PS1="\[${BOLD}${MAGENTA}\]\u \[$WHITE\]at \[$ORANGE\]\h \[$WHITE\]in \[$GREEN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"
}

gentoo_bash_prompt () {
    if [[ -n ${LS_COLORS:+set} ]]; then
	    if [[ "${EUID}" == 0 ]] ; then
            PS1='\[\033[01;31m\]\h\[\033[01;34m\] \w $(parse_git_branch) \$\[\033[00m\] '
	    else
            PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w $(parse_git_branch) \$\[\033[00m\] '
	    fi
    else
	    # show root@ when we don't have colors
	    PS1+='\u@\h \w \$ '
    fi
}

# color: http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
function prompt-clover-setup {
	local TTY=$(tty | cut -b6-) uc
	case "${EUID}" in
		(0) uc="${fg[1]}";;
		(*) uc="${fg[2]}";;
	esac
	PS1="\[${color[bold]}${fg[5]}\]-\[${fg[4]}\](\[${uc}\]\$·\[${fg[5]}\]\h:${TTY}\[${fg[4]}\]·\D{%m/%d}·\[${fg[5]}\]\A\[${fg[4]}\])-\[${fg[2]}\]»\[${color[none]}\] "
	PS2="\[${color[bold]}${fg[5]}\]-\[${fg[2]}\]» \[${color[none]}\]"
	PROMPT_DIRTRIM=3
	TITLEBAR="\$:\w"
}

PROMPT_COMMAND=my_extravagant_bash_prompt

#if [[ "$EUID" == 0 ]]; then
#    gentoo_bash_prompt
#else
#    my_extravagant_bash_prompt
#fi

[[ -n "$SCHROOT_CHROOT_NAME" ]] && PS1="($SCHROOT_CHROOT_NAME) $PS1"

# vim:fenc=utf-8:ft=sh:
