#!/bin/bash

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

# vim:fenc=utf-8:ft=sh:
