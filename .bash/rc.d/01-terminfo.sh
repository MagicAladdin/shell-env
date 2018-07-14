#
# Setup 256 colors terminal support on rxvt-unicode and xterm
#

have_term () {
	local i
	for i in ${HOME}/.terminfo /usr/{share,lib}/terminfo /etc/terminfo
	do
        [[ -n $i || -d $i ]] && [[ -r $i/${1:0:1}/$1 || -r $i/$1 ]] && return 0
    done
	return 1
}

case ${TERM-} in
    (tmux*)
	    have_term tmux || TERM=screen${TERM#tmux};;
    (screen*)
	    [[ -z ${TMUX:++} ]] || ! have_term tmux || TERM=tmux${TERM#screen};;
esac

case ${TERM-} in
    (xterm|screen|tmux|rxvt)
	    TERM=$TERM-256color;;
esac

# vim:fenc=utf-8:ft=sh:
