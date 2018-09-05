#!/bin/bash

BASEDIR=$(xdg-user-dir DOCUMENTS)

open_lukscontainer () {
    sudo cryptsetup luksOpen ${BASEDIR}/lukscontainer.img lukscontainer
    install -m 755 -d ${BASEDIR}/lukscontainer
    sudo chown wandsas:wandsas ${BASEDIR}/lukscontainer
    sudo mount /dev/mapper/lukscontainer ${BASEDIR}/lukscontainer
}

close_lukscontainer () {
    sudo umount ${BASEDIR}/lukscontainer
    rmdir ${BASEDIR}/lukscontainer
    sudo cryptsetup luksClose lukscontainer
}

main () {
    # Toggle open/close container
    if mountpoint -q ${BASEDIR}/lukscontainer >/dev/null 2>&1; then
        close_lukscontainer
    else
        open_lukscontainer
    fi
}
main "$@"

# vim:fenc=utf-8:ft=sh:
