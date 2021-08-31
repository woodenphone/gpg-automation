#!/usr/bin/env bash
## install-packages.ease-of-life.sh
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"
sudo apt-get install -y  screen tmux byobu nano vim curl wget git
sudo apt-get install -y p7zip p7zip-full p7zip-rar unzip zip tar bzip2 # Compression.

echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"