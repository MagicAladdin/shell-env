#
# User aliases
#

alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

check_com colordiff && alias diff=colordiff
check_com pydf && alias df='pydf' || alias df='df -h'
alias dus='du -sh'
alias free='free -h'
alias h='history'
alias j='jobs -l'

alias mkcd='mkdir $1 && cd $1'

alias cls=clear
alias res='cd && reset'

alias eqf='equery f'
alias equ='equery u'
alias eqh='equery h'
alias eqa='equery a'
alias eqb='equery b'
alias eql='equery l'
alias eqd='equery d'
alias eqg='equery g'
alias eqc='equery c'
alias eqk='equery k'
alias eqm='equery m'

alias qa=qatom
alias qc=qcache
alias qd=qdepends
alias qk=qcheck
alias qf=qfile
alias qg=qgrep
alias ql=qlist
alias qo=qlop
alias qp=qpkg
alias qm=qmerge
alias qs=qsearch
alias qz=qsize
alias qt=qtbz2
alias qu=quse
alias qx=qxpak

check_com hub && alias git=hub
alias gaa='git add --all'
alias gc='git commit --verbos --all'
alias gcm='git commit --message'
alias gpl='git pull'
alias gplr='git pull --rebase'
alias gplom='git pull origin master'
alias gplum='git pull upstream master'
alias gplgm='git pull github master'
alias gplwm='git pull wandsas master'
alias gp='git push'
alias gpa='git push --all'
alias gpA='git push --all && git push --tags'
alias gpt='git push --tags'
alias gpom='git push origin master'
alias gpum='git push upstream master'
alias gpgm='git push github master'
alias gpwm='git push wandsas master'
alias gr='git remote -v'
alias gra='git remote add'
alias grr='git remote rename'
alias grrm='git remote rm'
alias gRh='git reset --hard'
alias gRhh='git reset HEAD --hard'
alias gst='git status'

# Change to the root directory (toplevel) of the git repository
function gcd {
    cd $(git rev-parse --show-toplevel)
}

ssh () {
    case "$TERM" in
    (rxvt-256color|rxvt-unicode*)
        TERM=rxvt LANG=C LC_MESSAGES=C command ssh "$@"
        ;;
    (screen-256color|tmux-256color)
        TERM=screen LANG=C LC_MESSAGES=C command ssh "$@"
        ;;
    (xterm-256color)
        TERM=xterm LANG=C LC_MESSAGES=C command ssh "$@"
        ;;
    (*)
        LANG=C LC_MESSAGES=C command ssh "$@"
        ;;
    esac
}

alias tma='tmux attach'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'
tmux_killall_sessions () {
    local sessions=$(tmux list-sessions | awk -F ':' '{print $1}')
    [[ -z "$sessions" ]] && return
    for session in $sessions; do
        tmux kill-session -t $session
    done
}
alias tmka=tmux_killall_sessions
