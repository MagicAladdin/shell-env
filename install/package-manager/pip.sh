#!/bin/bash

[[ -f "/etc/init.d/functions.sh" ]] && source /etc/init.d/functions.sh

py_packages=(
"--upgrade setuptool"
"--upgrade pip"
websocket-client
nodeenv
pipenv
catalyst
gdbgui
fail2ban
maildir-deduplicate
gmailcount
pygments
pre-commit
github3
PyGithub
tmuxp
virtualenv
virtualenvwrapper
i3-py

)

echo -e \n"Installation of some python pip packages"

echo

read -p "Press any key to install python packages or Ctrl+C to abort..."

for pkg in ${py_packages[@]}; do
  pip install $pkg --user
done

# vim:fenc=utf-8:ft=sh:ts=2:sts=2:sw=2:et:ai:
