#!/bin/sh

git clone https://github.com/nodenv/nodenv.git ~/.nodenv
cd ~/.nodenv && src/configure && make -C src
pathmunge $HOME/.nodenv/bin

# vim:fenc=utf-8:ft=sh:
