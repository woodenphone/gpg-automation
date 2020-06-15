#!/usr/bin/env bash
## pi_setup.sh
## Setup GPG automation on a Raspberry Pi
## USAGE: $ sudo bash ./pi_setup.sh
## My intent is for this script to be a "Just run it" and whether things are installed or not at the start, they'll be there afterwards.
## By Ctrl-S 2020
echo "pi_setup.sh starting at `date +"%s"`"

# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/

## Update system
echo "Update system via apt-get at `date +"%s"`"
apt-get update
apt-get upgrade -y

## == Install prerequisites ==
## LINK: https://github.com/etsy/yubigpgkeyer/blob/master/README.md

## pinentry-hax from pinentry-hax in the same directory. Needed for setting the PIN unattended.
## LINK: https://gist.github.com/barn/e3ff508c3032da3ff905
## This is copied manually.

## Python 3
echo "Install python3 at `date +"%s"`"
apt-get install -y python3 python3-pip

## Brew (Package manager) 
## LINK: https://brew.sh/
## LINK: https://docs.brew.sh/Homebrew-on-Linux
echo "Install brew at `date +"%s"`"
sudo apt-get install build-essential curl file git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "Install Brew packages at `date +"%s"`"
## ykneomgr
brew install ykneomgr

## ykpers 
brew install ykpers

## gnupg2 version 2.0.27 only tested. 
brew install gnupg2


start_date=`date +"%s"` # Note to console script is at the start of the file
echo "pi_setup.sh finished at `date +"%s"`"