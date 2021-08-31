#!/usr/bin/env bash
## install-packages.filesystems.sh
## Install packages for most common filesystems.
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"
echo "#[${0##*/}]" "Install packages: Filesystems" "[at $(date +%c,\ @%s)]"
sudo apt-get install -y fdisk parted gparted
sudo apt-get install -y ntfs-3g # NTFS.
sudo apt-get install -y xfsdump xfsprogs # XFS.
sudo apt-get install -y hfsprogs hfsutils hfsplus dmg2img # HFS (Apple).
sudo apt-get install -y exfat-fuse exfat-utils # ExFAT (SD cards, flash drives).
sudo apt-get install -y dosfstools fatattr fatcat fatresize fusefat # FAT16, FAT32.
echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"