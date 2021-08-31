#!/usr/bin/env bash
## ubuntu-setup-for-regular-use.sh
## Set up a specified GPG key & smartcard on a daily-use machine.
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"
echo "#[${0##*/}]" "Teaching GPG to use key from file: ${1}"

echo "#[${0##*/}]" "Importing public key: ${1}"
gpg --import $1


## TODO: PCRE magic to avoid manual keyid/keygrip entry


echo "#[${0##*/}]" "Trust public key absolutely"
(   grep -v -e '^#' "dbg.set-key-trust.heredoc.txt" |\
    | grep -v -e '^#' \
    | tee "dbg.set-key-trust.stripped.txt" | tee /dev/tty \
    gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --expert --key-edit "$KEYID"
    | tee "dbg.set-key-trust.gpg-stdout.txt"
) <<EOF-set-key-trust
# gpg>
trust
## 5 = I trust ultimately
5
## Do you really want to set this key to ultimate trust? (y/N) y
y
## Save and exit
save
EOF-set-key-trust


echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"