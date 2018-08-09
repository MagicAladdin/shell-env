
# History search multi word
# https://github.com/zdharma/fast/syntax-highlighting/

zshrc_history_search_multi_word () {
  local basedir="/usr/share/zsh/site-contrib/history-search-multi-word"
  local rcfile="history-search-multi-word.plugin.zsh"

  [[ -r "${basedir}/${rcfile}" ]] && \
    source ${basedir}/${rcfile} || return

  zstyle ":history-search-multi-word" page-size "5"
  #zstyle ":history-search-multi-word" page-size "LINES/4"
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

if [[ -z "${ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD:++}" ]]
then  zshrc_history_search_multi_word
fi

# Free unused memory unless the user explicitly sets ZSHRC_KEEP_FUNCTIONS
if [[ -z "${ZSHRC_KEEP_FUNCTIONS:++}" ]]
then    unfunction zshrc_history_search_multi_word
fi

# vim:fenc=utf-8:ft=zsh:ts=2:sts=0:sw=2:et:
