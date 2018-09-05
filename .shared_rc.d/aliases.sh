# $Id: ~/.shared_rc.d/aliases.sh wandsas 2018/09/05

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ll='ls -lh'
alias la='ls -a'
alias  l='ls -lha'

alias dus='du -sh "$@"'
alias free='free -h'

alias h='history'
alias j='jobs -l'

alias cls=clear
alias res='cd && reset'

alias mkcd='mkdir $1 && cd $1'

check_com pydf && alias df=pydf || alias df='/bin/df -hPT | column -t'

check_com colordiff && alias diff=colordiff

# gentoo
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

# tmux
alias  tma='tmux attach'
alias  tmd='tmux detach-client'
alias tmls='tmux list-sessions'
alias tmks='tmux kill-session -t'

tmKs () {
  tmux list-sessions \
    | awk -F':' '{print $1}' \
    | xargs -n 1 tmux kill-session -t
}

# ssh
sshinfo () {
  ssh-add -l
  ssh -T git@github.com
}

ssh() {
    case "$TERM" in
	rxvt-256color|rxvt-unicode*)
	    LC__ORIGINALTERM=$TERM TERM=rxvt LANG=C LC_MESSAGES=C command ssh "$@"
	    ;;
	screen-256color|tmux-256color)
	    LC__ORIGINALTERM=$TERM TERM=screen LANG=C LC_MESSAGES=C command ssh "$@"
	    ;;
	*)
	    LANG=C LC_MESSAGES=C command ssh "$@"
	    ;;
    esac
}

# git
check_com git || return
check_com hub && alias git=hub
alias   gaa='git add --all'
# git branch
alias   gbu='git branch --set-upstream-to='
alias gbuom='git branch --set-upstream-to=origin/master master'
# git commit
alias    gc='git commit'
alias    gcm='git commit --message'
alias    gca='git commit --all'
alias   gcam='git commit --all --message'
alias   gcad='git commit --all --amend'
# git clone
alias    gcl='git clone'
alias   gcld='git clone depth=1'
alias   gclr='git clone recursive'
alias  gclrs='git clone recurse-submodules'
# git cherry-pick
alias    gcp='git cherry-pick'
alias   gcpa='git cherry-pick --abort'
alias   gcpc='git cherry-pick --continue'
# git diff
alias     gd='git diff'
alias    gdp='git diff --patience'
alias    gdc='git diff --cached'
alias    gdk='git diff --check'
alias   gdck='git diff --cached --checked'
alias    gdt='git difftool'
# git fetch
alias     gf='git fetch'
alias    gfo='git fetch origin'
alias    gfu='git fetch upstream'
### git format-patch
alias    gfp='git format-patch'
### git fsck
alias    gfk='git fsck'
### git grep
alias     gg='git grep'
### git log
alias     gl='git log --oneline'
alias    glg='git log --oneline --graph --decorate'
alias    gll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit'"
alias   glll="log --topo-order --stat --pretty=format:'%C(bold)%C(yellow)Commit:%C(reset) %C(yellow)%H%C(red)%d%n%C(bold)%C(yellow)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)%C(yellow)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'"
### git ls-files
alias    gls='git ls-files'
alias   glsf='!git ls-files | grep -i'
### git merge
alias     gm='git merge'
alias    gma='git merge --abort'
alias    gmc='git merge --continue'
alias    gms='git merge --skip'
### git checkout
alias    gco='git checkout'
alias   gcob='git checkout -b'    # checkout new-branch
### git prune
alias    gpr='git prune -v'
# git pull
alias   gpl='git pull'
alias  gplr='git pull --rebase'
alias  gplo='git pull origin'
alias gplro='git pull --rebase origin'
alias gplom='git pull origin master'
alias gplrom='git pull --rebase origin master'
alias  gplu='git pull upstream'
alias gplum='git pull upstream master'
alias gplrum='git pull --rebase upstream master'
alias gplgm='git pull github master'
alias gplrgm='git pull --rebase github master'
alias gplwm='git pull wandsas master'
alias gplrwm='git pull --rebase wandsas master'
### git push
alias    gp='git push'
alias   gpf='git push -f'
alias   gpu='git push -u'
alias   gpt='git push --tags'
alias   gpa='git push --all'
alias   gpA='git push --all && git push --tags'
alias   gpo='git push origin'
alias  gpom='git push origin master'
alias gpfom='git push -f origin master'
alias gpuom='git push -u origin master'
alias   gpu='git push upstream'
alias  gpum='git push upstream master'
alias  gpgm='git push github master'
alias   gpw='git push wandsas'
alias  gpwm='git push wandsas master'
alias  gpam='git push all master'
### git rebase
alias   grb='git rebase'
alias  grba='git rebase --abort'
alias  grbc='git rebase --continue'
alias  grbi='git rebase --interactive'
alias  grbs='git rebase --skip'
# git reset
alias   gre='git reset'
alias   grh='git reset HEAD'
alias  greh='git reset --hard'
alias  grem='git reset --mixed'
alias  gres='git reset --soft'
alias  grehh='git reset HEAD --hard'
alias  grehm='git reset HEAD --mixed'
alias  grehs='git reset HEAD --soft'
# git remote
alias    gr='git remote -v'
alias   gra='git remote add'
alias   grn='git remote rename'
alias   grr='git remote rm'
alias   grp='git remote prune'
alias   grs='git remote show'
alias  grao='git remote add origin'
alias  grro='git remote remove origin'
alias  grau='git remote add upsteam'
alias  grru='git remote remove upstream'
alias  grpo='git remote prune origin'
alias  grpu='git remote prune upstream'
### git rm
alias   grmf='git rm -f'
alias  grmrm='got rm -rf'
### git status
alias   gst='git status'
alias  gstb='git status -s -b'
### git stash
alias   gsa='git stash apply'
alias   gsc='git stash clear'
alias   gsd='git stash drop'
alias   gsl='git stash list'
alias   gsp='git stash pop'
alias   gss='git stash save'
alias   gsw='git stash show'
### git tag
alias    gt='git tag'
alias   gtd='git tag -d'
### git show
alias    gw='git show'
alias   gwp='git show -p'

gcd () {
  cd $(git rev-parse --show-toplevel)
}

# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:
