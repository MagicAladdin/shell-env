#!/bin/bash

wget -O /etc/default/grml-rescueboot \
    https://raw.github.com/grml/grml-rescueboot/master/etc/default/grml-rescueboot
wget -O /etc/grub.d/42_grml \
    https://raw.github.com/grml/grml-rescueboot/master/42_grml
chmod 755 /etc/grub.d/42_grml

install -d /boot/iso
wget -O /boot/iso/grml \
    http://download.grml.org/grml64-full_2017.05.iso

# vim:fenc=utf-8:ft=sh:
