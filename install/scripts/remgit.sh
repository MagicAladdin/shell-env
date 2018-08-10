#!/bin/bash

if [[ -f "$HOME/bin/remgit" ]];
    backupfile="remgit.disabled.$(date +%y%m%d)"
    echo "Found a version of remgit. Renaming the old version to $backupfile."
    mv $HOME/bin/remgit $HOME/$backupfile
fi

curl -o ~/bin/remgit --create-dirs -fsSL https://gist.githubusercontent.com/ckalima/1364886/raw/6fca7e98cc985d33e40bcf45a5044844bc058b63/remgit.sh
chmod 755 ~/bin/remgit
