#!/bin/bash

LIVE_BOOT=$home/live-boot

sudo apt-get install
  \ --no-install-recommends
  \ --no-install-suggests
  \ --assume-yes -q3
  \ debootstrap
  \ squashfs-tools
  \ xorriso
  \ grub-pc-bin
  \ grub-efi-amd64-bin
  \ mtools

sudo debootstrap
  \ --arch=i386
  \ --variant=minbase
  \ sid
  \ $LIVE_BOOT/sid32-chroot
  http://ftp.de.debian.org/debian

sudo chroot $LIVE_BOOT/sid32-chroot /bin/bash

== Inside chroot ==
```
echo "debian-live" > /etc/hostname

apt-get install
  \ --no-install-recommends
  \ --no-install-suggests
  \ linux-image-686
  \ live-boot
  \ systemd-sysv

# ...

```

mkdir -p $LIVE_BOOT/{scratch,image/live}

# Compress chroot environment into squash filesystem
sudo mksquashfs
  \ $LIVE_BOOT/sid32-chroot
  \ $LIVE_BOOT/image/live/filesystem.squashfs
  \ -e boot

# Copy kernel and initramfs from inside chroot to the live directory
cp $LIVE_BOOT/chroot/boot/vmlinuz-* $LIVE_BOOT/image/vmlinuz
cp $HOME/LIVE_BOOT/chroot/boot/initrd.img-* $HOME/LIVE_BOOT/image/initrd

# Tell grub to use the search command to find the device with our live environment
cat <<'EOF' >$LIVE_BOOT/scratch/grub.cfg

search --set=root --file /DEBIAN_CUSTOM

insmod all_video

set default="0"
set timeout=30

menuentry "Debian Live" {
    linux /vmlinuz boot=live quiet nomodeset
    initrd /initrd
}
EOF

# Create unique file defined in grub.cfg to help grub figure out 
# which device contains out live filesystem
touch $LIVE_BOOT/image/DEBIAN_CUSTOM

# Yout LIVE_BOOT should not look like this
LIVE_BOOT/sid32-chroot/*chroot files*
LIVE_BOOT/scratch/grub.cfg
LIVE_BOOT/image/DEBIAN_CUSTOM
LIVE_BOOT/image/initrd
LIVE_BOOT/image/vmlinuz
LIVE_BOOT/image/live/filesystem.squashfs


# Create grub bios image
grub-mkstandalone
  \ --format=i386-pc
  \ --output=$HOME/LIVE_BOOT/scratch/core.img
  \ --install-modules="linux normal iso9660 biosdisk memdisk search tar ls"
  \ --modules="linux normal iso9660 biosdisk search"
  \ --locales=""
  \ --fonts=""
  \ "boot/grub/grub.cfg=$LIVE_BOOT/scratch/grub.cfg"


# Combine bootable grub cdboot.img bootloader with our bootimage
cat /usr/lib/grub/i386-pc/cdboot.img
  \ $LIVE_BOOT/scratch/core.img
  \ > $LIVE_BOOT/scratch/bios.img


xorriso
  \ -as mkisofs
  \ -iso-level 3
  \ -full-iso9660-filenames
  \ -volid "DEBIAN_CUSTOM"
  \ --grub2-boot-info
  \ --grub2-mbr /usr/lib/grub/i386-pc/boot_hybrid.img
  \ -eltorito-bootg
  \ boot/grub/bios.img
  \ -no-emul-boot
  \ -boot-load-size 4
  \ -boot-info-table
  \ --eltorito-catalog boot/grub/boot.cat
  \ -output "${HOME}/LIVE_BOOT/debian-custom.iso"
  \ -graft-points
  \ $LIVE_BOOT/image
  \ /boot/grub/bios.img=$LIVE_BOOT/scratch/bios.img


#
# Create bootable USB
#

disk=/dev/sda

install -d /mnt/sid32

# Partition USB drive
sudo parted --script $disk
  \ mklabel msdos
  \ mkpart primary fat32 1MiB 100%

# Format partition
sudo mkfs.vfat -F32 $disk1
doslabel $disk sid32

# Mount partition
mount LABEL=sid32 /mnt/sid32

# Install grub for i386-booting
sudo grub-install
  \ --target=i386-pc
  \ --boot-directory=/mnt/sid32/boot
  \ --recheck
    $disk

# Create live directory on USB device
sudo mkdir -p /mnt/sid32/{boot/grub,live}

# Copy the Debian live environment files we previously generated to the USB disk
sudo cp -r $LIVE_BOOT/image/* /mnt/sid32/

# Copy the grub.cfg boot configuration to the USB device
sudo cp $LIVE_BOOT/scratch/grub.cfg /mnt/sid32/boot/grub/grub.cfg

sudo umount /mnt/sid32 && rmdir /mnt/sid32

ENJOY


# vim:fenc=utf-8:ft=sh:ts=2:sts=0:sw=2:et:
