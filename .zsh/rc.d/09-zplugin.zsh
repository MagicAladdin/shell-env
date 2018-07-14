#
# Zplugin - Zsh plugin manager
#

# {{{ Is zplugin disabled?

[[ -z "$ZPLUGIN" ]] && return

# }}}

# {{{ Zplugin installer

__zplugin_install () {
    rm -f ~/.zcompdump ~/.zdirs ~/.zsh/{completions,functions}.zwc*
    [[ -d "${ZDOTDIR}/.zplugin" ]] && rm -rf ${ZDOTDIR}/.zplugin
    mkdir -p ${ZDOTDIR}/.zplugin/bin
    git clone https://github.com/zdharma/zplugin.git ${ZDOTDIR}/.zplugin/bin
}

[[ -f "${ZDOTDIR}/.zplugin/bin/zplugin.zsh" ]] || __zplugin_install

# }}}}

# {{{ Zplugin loader

source "${ZDOTDIR}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# }}}

# {{{ Completions

#zplugin ice blockf
#zplugin light zsh-users/zsh-completions

#zplugin ice blockf
#zplugin light gentoo/gentoo-zsh-completions

# }}}

# {{{ Programs

zplugin ice from"gh-r" as"program" mv"shfmt* -> shfmt"
zplugin light mvdan/sh

#zplugin ice from"gh-r" as"program" mv"docker* -> docker-compose"
#zplugin light docker/compose

#zplugin ice as"program" make'!' atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' src"zhook.zsh"
#zplugin light direnv/direnv

#zplugin ice from"gh-r" as"program"
#zplugin light junegunn/fzf-bin

zplugin ice
zplugin light abishekvashok/cmatrix

# }}}

# {{{ Plugins

zplugin ice pick"h.sh"
zplugin light paoloantinori/hhighlighter

# }}}

# {{{ Scripts

zplugin ice wait"2" lucid as"program" pick"$ZPFX/bin/git-alias" make"PREFIX=$ZPFX"
zplugin light tj/git-extras

zplugin ice as"program" pick"bin/git-dsf"
zplugin light zdharma/zsh-diff-so-fancy

# }}}

# {{{ Snippets
# }}}

# {{{ Psprint libraries

# zsh-morpho available screensaver: zmorpho, zmandelbrot, zblank
zstyle ":morpho" screen-saver "zmandelbrot"
zplugin load psprint/zsh-morpho

zplugin load psprint/zsh-cmd-architect

zplugin load psprint/zsh-editing-workbench

zplugin load psprint/zsh-navigation-tools

zplugin load psprint/zsh-select

# }}}

# {{{ Zsh-users libraries

zplugin ice wait"1" atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

#zplugin ice wait"0"
#zplugin light zsh-users/zsh-history-substring-search

#zplugin ice wait"0"
#zplugin light zsh-users/zsh-syntax-highlighting

# }}}

# {{{ Zdharma libraries

#zplugin load zdharma/zbrowse

zplugin ice wait"0"
zplugin light zdharma/zconvey
zplugin ice wait"0" as"command" pick"cmds/zc-bg-notify" silent
zplugin light zdharma/zconvey

zplugin ice compile"*.lzui"
zplugin light zdharma/zui

#zplugin light zdharma/zplugin-crasis

zplugin ice wait"0"
zplugin light zdharma/history-search-multi-word

#zplugin ice wait"0" atinit"zpcompinit; zpcdreplay"
zplugin ice wait"0"
zplugin light zdharma/fast-syntax-highlighting

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:
