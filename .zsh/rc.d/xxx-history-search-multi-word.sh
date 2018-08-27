# $Id: ~/.zsh/rc.d/xxx-history-search-multi-word.sh wandsas 2018/08/09

# Zsh history search multi word
# https://github.com/zdharma/fast/history-search-multi-word

zshrc_history_search () {
  local basedir="/usr/share/zsh/site-contrib/history-search-multi-word"
  local hsmwrc="history-search-multi-word.plugin.zsh"

  [[ -r "${basedir}/${hsmwrc}" ]] && \
    source ${basedir}/${hsmwrc} || return

  #zstyle ":history-search-multi-word" page-size "5"
  zstyle ":history-search-multi-word" page-size "LINES/4"
  zstyle ":history-search-multi-word" highlight-color "fg=yellow,bold"
  # Whether perfom syntax highlighting (default true)
  zstyle ":plugin:history-search-multi-word" synhl "yes"
  # Clear query on Ctrl+C or ESC
  zstyle ":plugin:history-search-multi-word" clear-on-cancel "yes"
  # Effect on active history entry. Try stdout, bold bg=blue
  zstyle ":plugin:history-search-multi-word" active "underline"
  # Check paths for existence and mark with magenta (default true)
  zstyle ":plugin:history-search-multi-word" check-paths "yes"

  typeset -gA HSMW_HIGHLIGHT_STYLES
  HSMW_HIGHLIGHT_STYLES[path]="bg=magenta,fg=white,bold"
  # enable coloring of options, e.g. "-o" and "--option", with cyan:
  HSMW_HIGHLIGHT_STYLES[single-hyphen-option]="fg=cyan"
  HSMW_HIGHLIGHT_STYLES[double-hyphen-option]="fg=cyan"
  # highlight command separators, like ";" or "&&"
  HSMW_HIGHLIGHT_STYLES[commandseparator]="fg=241,bg=17"
}

if [[ -z "${ZSHRC_SKIP_HISTORY_SEARCH:++}" ]]
then  zshrc_history_search
fi

# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
if [[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]]
then    unfunction zshrc_history_search
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:
