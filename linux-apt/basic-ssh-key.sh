#!/usr/bin/env bash
## basic-ssh-key
## Generate a SSH RSA keypair for the current user
## This does nothing with GPG; it's only here because testing needed it done.
## https://www.man7.org/linux/man-pages/man1/ssh-keygen.1.html
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"


echo "#[${0##*/}]" "Ensure dir exists: ~/.ssh/"
mkdir -vp ~/.ssh/


if [[ -f ~/.ssh/id_rsa ]];
then
    echo "#[${0##*/}]" "Found id_rsa, skipping creation"
else
    echo "#[${0##*/}]" "Create id_rsa"
    ssh-keygen -v -c  -p ""-t rsa -b 4096 -f ~/.ssh/id_rsa -C "${USER}@$(hostname) [generated at $(date +%c,\ @%s)]"
fi


if [[ -f ~/.ssh/id_ed25519 ]];
then
    echo "#[${0##*/}]" "Found id_ed25519, skipping creation"
else
    echo "#[${0##*/}]" "Create id_ed25519"
    ssh-keygen -v -c  -p ""-t rsa -b 4096 -f ~/.ssh/id_ed25519 -C "${USER}@$(hostname) [generated at $(date +%c,\ @%s)]"
fi


echo "#[${0##*/}]" "Setting correct permissions for ~/.ssh/"
chmod -v 700 ~/.ssh/
chmod -v 600 ~/.ssh/*


echo "#[${0##*/}]" "Listing keys ssh client knows about"
ssh-add -l


echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"