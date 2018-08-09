# $Id: ~/.bash/rc.d/02-set-title.sh wandsas 2018/08/09
#
# Activate support for title from https://github.com/vaeth/runtitle/
#

# vaeth/runtitle is not supported as root user
[[ "$EUID" == 0 ]] && return

if check_com title; then
	set_title() {
		local a b
		a=(${=${(@)${=1}:t}})
		a=(${=${a##[-\&\|\(\)\{\}\;]*}})
		[[ $#a > 3 ]] && b=' ...' || b=
		a=${a[1,3]}
		[[ $#a -gt 30 ]] && a=$a[1,22]'...'$a[-5,-1]
		title $a$b
	}
    preexec () { set_title; }
fi

# vim:fenc=utf-8:ft=sh:
