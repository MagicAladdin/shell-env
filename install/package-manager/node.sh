#!/bin/bash

PKGS=(
github-releases
gitbook-cli
jscpd
jsctags
jsinspect
flow-language-server
javascript-typescript-langserver
ocaml-language-server
netlify-cli
now
parker
prettier
serve
source-map-explorer
surge
svgo
tern
overtime-cli
rtm-cli
get-links-cli
pre-commit
grunt-cli
octicons
devicons
)

for pkg in $PKGS[@]; do
  node install $pkg
done

unset PKGS pkg

# vim:fenc=utf-8:ft=sh:ts=2:sts=2:sw=2:et:ai:ci:pi:fdm=marker:foldlevel=0:
# -*- mode: sh -*-
