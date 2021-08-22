#!/usr/bin/env bash
## ubuntu.step01-online.sh
## Do all the tasks on ubuntu that require a network connection.
## Run as root
## Modified: 2021-08-18
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"
## Log useful debug info
echo "#[${0##*/}]" "USER=$USER"
echo "#[${0##*/}]" "hostname: $(hostname)"
echo "#[${0##*/}]" "uname: $(uname -a)"
echo "#[${0##*/}]" "system-release: $(cat /etc/system-release)"


echo "#[${0##*/}]" "Install packages: Update all" "[at $(date +%c,\ @%s)]"
sudo apt-get update
sudo apt-get upgrade -y

echo "#[${0##*/}]" "Install packages: Useful" "[at $(date +%c,\ @%s)]"
# sudo apt-get install -y build-essential file # C Compiling.
sudo apt-get install -y p7zip p7zip-full p7zip-rar unzip zip tar bzip2 # Compression.
sudo apt-get install -y  screen tmux byobu # Terminal.
sudo apt-get install -y  nano vim # Editors.
sudo apt-get install -y  curl wget git # Network transfers.

echo "#[${0##*/}]" "Install packages: Filesystems" "[at $(date +%c,\ @%s)]"
sudo apt-get install -y fdisk parted gparted


sudo apt-get install -y ntfs-3g # NTFS.
sudo apt-get install -y xfsdump xfsprogs # XFS.
sudo apt-get install -y hfsprogs hfsutils hfsplus dmg2img # HFS (Apple).
sudo apt-get install -y exfat-fuse exfat-utils # ExFAT (SD cards, flash drives).
sudo apt-get install -y dosfstools fatattr fatcat fatresize fusefat # FAT16, FAT32.


# echo "#[${0##*/}]" "Install packages: Yubikey" "[at $(date +%c,\ @%s)]"
#apt-get install -y python-yubico-tools python3-yubico python3-yubikey-manager yubikey-manager yubikey-personalization yubikey-personalization-gui
## TODO: Determine minimum required packages


echo "#[${0##*/}]" "Install packages: Useful" "[at $(date +%c,\ @%s)]"
echo "#[${0##*/}]" "Install packages: Required (Drduh)" "[at $(date +%c,\ @%s)]"
sudo apt -y install wget gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools yubikey-personalization

echo "#[${0##*/}]" "Install packages: Ubuntu (Drduh)" "[at $(date +%c,\ @%s)]"
sudo apt -y install libssl-dev swig libpcsclite-dev


echo "#[${0##*/}]" "Install packages: Python" "[at $(date +%c,\ @%s)]"
sudo apt -y install python3-pip python3-pyscard

echo "#[${0##*/}]" "Install packages: Python libraries" "[at $(date +%c,\ @%s)]"
pip3 install PyOpenSSL
pip3 install yubikey-manager



echo "#[${0##*/}]" "Finished installing packages" "[at $(date +%c,\ @%s)]"



echo "#[${0##*/}]" "Start smartcard daemon" "[at $(date +%c,\ @%s)]"
sudo service pcscd start



echo "#[${0##*/}]" "Download docs: Drduh" "[at $(date +%c,\ @%s)]"
git clone 'https://github.com/drduh/YubiKey-Guide.git' 'drduh.YubiKey-Guide'


echo "#[${0##*/}]" "Download conf: Drduh" "[at $(date +%c,\ @%s)]"
wget -O $GNUPGHOME/gpg.conf https://raw.githubusercontent.com/drduh/config/master/gpg.conf
grep -ve "^#" $GNUPGHOME/gpg.conf



echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"