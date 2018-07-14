#
# ZSH modules
#

# see man zshmodules

# Zsh edit small files with the command line editor
autoload -U zed

# Zsh massive renaming
autoload -U zmv
alias mmv='noglob zmv -W'

# Zsh calculator. Understands most ordinary arithmetic expressions
autoload -Uz zcalc

# Like GNU xargs
autoload -U zargs

# Python virtualenv
autoload -Uz workon

# ZSH hooks
autoload -U is-at-least

# ZSH mime extensions
zstyle ":mime:*" current-shell true
autoload -Uz zsh-mime-setup && zsh-mime-setup

# Smart pasting and escaping
autoload -Uz bracketed-paste-url-magic
zle -N bracketed-paste bracketed-paste-url-magic

# Smart URLs
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Helping system
autoload -Uz run-help run-help-sudo run-help-git run-help-openssl run-help-ip

# Compile functions
check_com precompile && () {
    autoload -U precompile && precompile
}

# Don't correct these commands
alias man='nocorrect man'
alias mkdir='nocorrect mkdir'
alias mv='nocorrect mv'

# For extensions, we use the defaults of zsh-mime-setup
# see /etc/mailcap, /etc/mime.types for system configs
# and ~/.mailcap, ~/.config/mimeapps.list for user configs.
zstyle ":mime:*" current-shell true
zsh-mime-setup

# vim:fenc=utf-8
