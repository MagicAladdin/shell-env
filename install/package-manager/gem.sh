#!/bin/bash

pkgs=(
taskwarrior-web
github-release
pre-commit
)

for pkg in ${pkgs[@]}; do
    gem installl $pkg
done

unset pkgs

# vim:fenc=utf-8:ft=sh:ts=4:sts=4:sw=4:et:
