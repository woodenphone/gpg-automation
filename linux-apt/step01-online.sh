#!/usr/bin/env bash
## step01-online.sh
## Do all the tasks  that require a network connection.
## Run as root
## Modified: 2021-08-18
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"
## Log useful debug info
echo "#[${0##*/}]" "USER=$USER"
echo "#[${0##*/}]" "hostname: $(hostname)"
echo "#[${0##*/}]" "uname: $(uname -a)"
echo "#[${0##*/}]" "system-release: $(cat /etc/system-release)"
echo "#[${0##*/}]" "Ensure sudo is available" "$(sudo whoami)"

# echo "#[${0##*/}]" "Install packages: Update all" "[at $(date +%c,\ @%s)]"
# sudo apt-get update && sudo apt-get upgrade -y


echo "#[${0##*/}]" "Install packages: Useful" "[at $(date +%c,\ @%s)]"
sudo apt-get install -y  screen tmux byobu nano vim curl wget git

# echo "#[${0##*/}]" "Install packages: Yubikey" "[at $(date +%c,\ @%s)]"
#apt-get install -y python-yubico-tools python3-yubico python3-yubikey-manager yubikey-manager yubikey-personalization yubikey-personalization-gui
## TODO: Determine minimum required packages

echo "#[${0##*/}]" "Install packages: Required (Drduh)" "[at $(date +%c,\ @%s)]"
sudo apt -y install wget gnupg2 gnupg-agent dirmngr cryptsetup scdaemon pcscd secure-delete hopenpgp-tools yubikey-personalization

echo "#[${0##*/}]" "Install packages: Ubuntu (Drduh)" "[at $(date +%c,\ @%s)]"
# sudo apt -y install libssl-dev swig libpcsclite-dev

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
wget -O "drduh/gpg.conf" https://raw.githubusercontent.com/drduh/config/master/gpg.conf
cp "drduh/gpg.conf "$GNUPGHOME/gpg.conf"
grep -ve "^#" $GNUPGHOME/gpg.conf


echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"