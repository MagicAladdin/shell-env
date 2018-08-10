#!/bin/bash

set -o nounset
set -o errexit
set -o pipefail

KVM_DIR=${KVM_DIR:-/var/lib/libvirt/images}

PROG=${0##*/}
lock=/var/run/$PROG

die () { echo $1; exit 1; }

exec 9>$lock
if ! flock -n 9  ; then eerror "${lock} held for ${PROG}, quitting"; fi

local vmname="$1"
local hostname="$vmname"
local disksize="$2G"
local ramsize="$3M"
local filename="$vmname.img"

[[ "${#}" != 2 ]] && eerror "Usage ${0##*/} <guestname> <disksize> <ramsize>"

qemu-img create
  \ -f qcow2
  \ $KVM_DIR/$filename
  \ $disksize
  \ || die "qemu-image create failed"

exec qemu-system-x86_64
  \ -enable-kvm
  \ -cpu host
  \ -drive file=$KVM_DIR/$filename,if=virtio
  \ -net nic -net user,hostname=$hostname
  \ -m $ramsize
  \ -monitor stdio
  \ -name $vmname
  \ "${@}"
  \ || die "qemu-system build vm failed"

# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:
