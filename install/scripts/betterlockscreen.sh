#!/bin/bash

WALLPAPERS=$HOME/.wallpapers

GENTOO=$WALLPAPERS/gentoo-09-larry-abducted-1680-1050.png

GRML=$WALLPAPERS/grml-cable-0.4.jpg

FUTURE=$WALLPAPERS/future-02-asia-city-rain.jpg


betterlockscreen \
    --update $GENTOO \
    --resolution 1920x1080 \
    --blur 0.5

# vim:fenc=utf-8:ft=sh
