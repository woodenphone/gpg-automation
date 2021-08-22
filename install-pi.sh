#!/usr/bin/env bash
## install-pi.sh
## Setup GPG automation on a Raspberry Pi
## USAGE: $ bash ./install-pi.sh
## My intent is for this script to be a "Just run it" and whether things are installed or not at the start, they'll be there afterwards.
## By Ctrl-S 2020

# Use 'strict mode' for BASH to avoid bugs that can break something
set -euo pipefail # https://devhints.io/bash
IFS=$'\n\t' # http://redsymbol.net/articles/unofficial-bash-strict-mode/


pfx="install-pi:" # Message prefix
echo "$pfx starting at t=`date -u +"%s"`"

## Update system
echo "$pfx Update system via apt-get at t=`date -u +"%s"`"
sudo apt-get update
sudo apt-get upgrade -y

## == Install prerequisites ==
## LINK: https://github.com/etsy/yubigpgkeyer/blob/master/README.md

## Python 3
echo "$pfx Install python3 at t=`date -u +"%s"`"
sudo apt-get install -y python3 python3-pip

## Brew (Package manager) 
## LINK: https://brew.sh/
## LINK: https://docs.brew.sh/Homebrew-on-Linux
echo "$pfx Install brew stage1 (Brew prerequisites) at t=`date -u +"%s"`"
sudo apt-get install build-essential curl file git ## Brew prerequisites.
echo "$pfx Install brew stage2 (Brew itself) at t=`date -u +"%s"`"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo "$pfx Install brew stage3 (postinstall, make 'brew' work as a command) at t=`date -u +"%s"`"
##- Configure Homebrew in your /home/pi/.profile by running
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/pi/.profile
##- Add Homebrew to your PATH
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
##- We recommend that you install GCC by running:
brew install gcc


echo "$pfx Install desired Brew packages at t=`date -u +"%s"`"
## ykneomgr
brew install ykneomgr

## ykpers 
brew install ykpers

## gnupg2 version 2.0.27 only tested. 
brew install gnupg2

echo "$pfx Clone yubigpgkeyer repo at t=`date -u +"%s"`"
git clone "https://github.com/etsy/yubigpgkeyer.git"

## pinentry-hax from pinentry-hax in the same directory. Needed for setting the PIN unattended.
## LINK: https://gist.github.com/barn/e3ff508c3032da3ff905
## (Must be named "pinentry-hax")
cp "./not_my_code/pinentry_hax" "./yubigpgkeyer/pinentry_hax"

start_date=`date -u +"%s"` # Note to console script is at the start of the file
echo "$pfx finished at t=`date -u +"%s"`"