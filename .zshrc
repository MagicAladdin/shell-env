# $Id: ~/.zshrc wandsas 2018/08/10
#
# Wandsas ~/.zshrc

# Allow disabling of entire environment suite
[[ -n "$INHERIT_ENV" ]] && return

sh_load_status .zshrc

# {{{ Configure ZSH features

# Empty means loading the feature

# 1. https://github.com/psprint/zsh-morpho
ZSHRC_SKIP_ZMORPHO=

# 2. https://github.com/zdharma/history-search-multi-word
ZSHRC_SKIP_HISTORY_SEARCH_MULTI_WORD=

# 3. https://github.com/zdharma/fast-syntax-highlighting
ZSHRC_SKIP_FAST_SYNTAX_HIGHLIGHTING=

# 4. https://github.com/zsh-users/zsh-autosuggestions
ZSHRC_SKIP_AUTOSUGGESTIONS=

ZSHRC_KEEP_FUNCTIONS=

# }}}

# {{{ Profiling

[[ -n "$ZSH_PROFILE_RC" ]] && zmodload zsh/zprof

# }}}

# {{{ Options

sh_load_status 'setting options'

setopt                       \
     NO_all_export           \
        always_last_prompt   \
     NO_always_to_end        \
        append_history       \
        auto_cd              \
        auto_list            \
        auto_menu            \
     NO_auto_name_dirs       \
        auto_param_keys      \
        auto_param_slash     \
        auto_pushd           \
        auto_remove_slash    \
     NO_auto_resume          \
        bad_pattern          \
        bang_hist            \
     NO_beep                 \
     NO_brace_ccl            \
        correct_all          \
     NO_bsd_echo             \
        cdable_vars          \
     NO_chase_links          \
     NO_clobber              \
        complete_aliases     \
        complete_in_word     \
     NO_correct              \
        correct_all          \
        csh_junkie_history   \
     NO_csh_junkie_loops     \
     NO_csh_junkie_quotes    \
     NO_csh_null_glob        \
        equals               \
        extended_glob        \
        extended_history     \
        function_argzero     \
        glob                 \
     NO_glob_assign          \
        glob_complete        \
     NO_glob_dots            \
        glob_subst           \
     NO_hash_cmds            \
        hash_dirs            \
        hash_list_all        \
        hist_allow_clobber   \
        hist_beep            \
        hist_ignore_dups     \
        hist_ignore_space    \
     NO_hist_no_store        \
        hist_verify          \
     NO_hup                  \
     NO_ignore_braces        \
     NO_ignore_eof           \
        interactive_comments \
     NO_ksh_glob             \
     NO_list_ambiguous       \
     NO_list_beep            \
        list_types           \
        long_list_jobs       \
        magic_equal_subst    \
     NO_mail_warning         \
     NO_mark_dirs            \
     NO_menu_complete        \
        multios              \
     NO_nomatch              \
        notify               \
     NO_null_glob            \
        numeric_glob_sort    \
     NO_overstrike           \
        path_dirs            \
        posix_builtins       \
     NO_print_exit_value     \
     NO_prompt_cr            \
        prompt_subst         \
        pushd_ignore_dups    \
     NO_pushd_minus          \
        pushd_silent         \
        pushd_to_home        \
        rc_expand_param      \
     NO_rc_quotes            \
     NO_rm_star_silent       \
     NO_sh_file_expansion    \
        sh_option_letters    \
        short_loops          \
        sh_word_split        \
     NO_single_line_zle      \
     NO_sun_keyboard_hack    \
        unset                \
     NO_verbose              \
        zle

if [[ $ZSH_VERSION_TYPE == 'new' ]]; then
  setopt                       \
     NO_hist_expire_dups_first \
        hist_find_no_dups      \
     NO_hist_ignore_all_dups   \
     NO_hist_no_functions      \
     NO_hist_save_no_dups      \
        inc_append_history     \
        list_packed            \
     NO_rm_star_wait
fi

# }}}

# {{{ Infopath

typeset -U infopath
infopath=(
    $HOME/{share/,}info(N)
    /usr/{local/,}share/info/(N)
    $infopath
        )

# }}}

# {{{ Manpath

typeset -U manpath
manpath=(
    $ZDOTDIR/share/man/(N)
    /usr/{,local/,}share/man(N)
    $manpath[@]
    )

# }}}

# {{{ Miscellaneous

sh_load_status 'miscellaneous'

# {{{ ls colours

(( $+commands[dircolors] )) && () {
    if [[ -r "~/.dir_colors" ]] {
        eval $(dircolors -b ~/.dir_colors)
    } elif [[ -r "/etc/DIR_COLORS" ]] {
        eval $(dircolors -b /etc/DIR_COLORS)
    } else { eval $(dircolors) }
}

autoload -U is-at-least

is-at-least 3.1.5 && () {
    zmodload -i zsh/complist

    zstyle ':completion:*' list-colors ''
    zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#)*=00=01:32'
    # completion colours
    zstyle ':completion:*' list-colors $LS_COLORS
}

# Is GNU ls available?
if ls --color=auto / >/dev/null 2>&1; then
  alias ls='command ls --color=auto'
elif ls -G / >/dev/null 2>&1; then
  alias ls='command ls -G'
fi
alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'

# }}}

# {{{ grep colors

if grep --color=auto -q "a" <<< "a" >/dev/null 2>&1; then
  alias  grep='command grep  --color=auto'
  alias egrep='command egrep --color=auto'
  alias ngrep='command ngrep --color=auto'
  alias zgrep='command zgrep --color=auto'
fi

# }}}

# {{{ less colors

(( ${terminfo[colors]:-0} >= 8 )) && () {
  export LESS_TERMCAP_mb=$'\E[1;31m'
  export LESS_TERMCAP_md=$'\E[1;38;5;74m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_so=$'\E[1;3;5;246m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[1;32m'
}

# }}}

# {{{ Don't always autlogout

unset TMOUT

# }}}

# }}}

# {{{ Running local hooks

sh_load_status 'local hooks'
run_hooks .zshrc.d

# }}}

# {{{ Profiling report

if [[ -n "$ZSHRC_PROFILE_RC" ]]; then
    zprof >! ~/zshrc.zprof
    exit
fi

# }}}

# {{{ Init Direnv chdir hooks

eval "$(direnv hook zsh)"

# }}}

# vim:fenc=utf-8:ft=zsh:fdm=marker:foldlevel=0:
