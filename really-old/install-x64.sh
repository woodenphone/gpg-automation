#!/usr/bin/env bash
## setup.sh
## Setup GPG automation on a PC
## USAGE: $ bash ./pi_setup.sh
## My intent is for this script to be a "Just run it" and whether things are installed or not at the start, they'll be there afterwards.
## By Ctrl-S 2020
echo "pi_setup.sh starting at t=`date -u +"%s"`"

# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/

## Update system
echo "Update system via apt-get at t=`date -u +"%s"`"
sudo apt-get update
sudo apt-get upgrade -y

## == Install prerequisites ==
## LINK: https://github.com/etsy/yubigpgkeyer/blob/master/README.md

## Python 3
echo "Install python3 at t=`date -u +"%s"`"
sudo apt-get install -y python3 python3-pip

## Brew (Package manager) 
## LINK: https://brew.sh/
## LINK: https://docs.brew.sh/Homebrew-on-Linux
echo "Install brew stage1 (Brew prerequisites) at t=`date -u +"%s"`"
sudo apt-get install build-essential curl file git ## Brew prerequisites.
echo "Install brew stage2 (Brew itself) at t=`date -u +"%s"`"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo "Install brew stage3 (postinstall, make 'brew' work as a command) at t=`date -u +"%s"`"



echo "Install desired Brew packages at t=`date -u +"%s"`"
## ykneomgr
brew install ykneomgr

## ykpers 
brew install ykpers

## gnupg2 version 2.0.27 only tested. 
brew install gnupg2

echo "Clone yubigpgkeyer repo at t=`date -u +"%s"`"
git clone "https://github.com/etsy/yubigpgkeyer.git"

## pinentry-hax from pinentry-hax in the same directory. Needed for setting the PIN unattended.
## LINK: https://gist.github.com/barn/e3ff508c3032da3ff905
## (Must be named "pinentry-hax")
cp "./not_my_code/pinentry_hax" "./yubigpgkeyer/pinentry_hax"

start_date=`date -u +"%s"` # Note to console script is at the start of the file
echo "pi_setup.sh finished at t=`date -u +"%s"`"