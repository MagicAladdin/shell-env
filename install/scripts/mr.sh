#!/bin/bash

#
# Get Myrepos mr, make it executable and add it to PATH, if it not exists in PATH.
#

if [[ -f "$HOME/bin/mr" ]]; then
    backupfile="mr.disabled.$(date +%Y%m&d)"
    echo "Found a version of mr. Renaming the old version to $backupfile"
    mv $HOME/bin/mr $HOME/bin/$backupfile
fi

curl -o ~/bin/mr --create-dirs -fsSL https://raw.githubusercontent.com/wandsas/myrepos/master/mr
chmod 755 ~/bin/mr

# vim:fenc=utf-8:ft=sh:
