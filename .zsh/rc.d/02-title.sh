#
# Activate support for title from https://github.com/vaeth/runtitle/
#

# vaeth/runtitle is not supported as root user
(($+commands[title])) && {
    autoload -U add-zsh-hook
    # Title are the first 3 words starting with sane chars (paths cutted)
	# We also truncate to at most 30 characters and add dots if args follow
	set_title() {
		local a b
		a=(${=${(@)${=1}:t}})
		a=(${=${a##[-\&\|\(\)\{\}\;]*}})
		[[ $#a > 3 ]] && b=' ...' || b=
		a=${a[1,3]}
		[[ $#a -gt 30 ]] && a=$a[1,22]'...'$a[-5,-1]
		title $a$b
	}
	add-zsh-hook preexec set_title
}

# vim:fenc=utf-8:ft=zsh:
