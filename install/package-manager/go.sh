#!/bin/bash

pkgs=(
aktau/github-release
direnv/direnv
motemen/ghq
monochromegane/the_platinum_searcher/...
mvdan.cc/sh/cmd/shfmt
ncw/rclone
gorilla/mux
nsf/gocode
)

for pkg in ${PKGS[@]}; do
    go get github.com/$pkg
done

unset PKGS

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:sw=4:et:
