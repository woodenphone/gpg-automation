#!/bin/bash
## create-secret-keys.sh
echo "#[${0##*/}]" "Start" "$(date +%Y-%m-%dT%H:%M:%S%z=@%s)]"


## ==========< Sanity check env vars >========== ##
## Exit fail if unset: ${PARAMETER:?WORD}
echo "GPG_KEY_LENGTH" ${GPG_KEY_LENGTH:?Env var not set}
echo "GPG_KEY_FULLNAME" ${GPG_KEY_FULLNAME:?Env var not set}
echo "GPG_KEY_EMAIL" ${GPG_KEY_EMAIL:?Env var not set}
echo "GPG_KEY_COMMENT" ${GPG_KEY_COMMENT:?Env var not set}
## ==========< /Sanity check env vars >========== ##


echo "#[${0##*/}]" "Create master key"
(   tee "dbg.create-master-key.heredoc.txt" \
    | grep -v -e '^#' \
    | tee "dbg.create-master-key.stripped.txt" \
    | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --with-colons \
    --expert --full-generate-key 2>&1 \
    | tee "dbg.create-master-key.gpg-stdout.txt" \
    | perl -ne 'print "$1\n" if m/^gpg: key ([A-Z0-9]+) marked as ultimately trusted/;' \
    | tee /dev/tty \
    | tee "key-fingerprint.txt"
) <<EOF-create-master-key
# gpg>
## Please select what kind of key you want:
## (8) RSA (set your own capabilities)
8
## Toggle/set key capabilities:
## Possible actions for a RSA key: Sign Certify Encrypt Authenticate
## Current allowed actions: Sign Certify Encrypt
e
s
## Current allowed actions: Certify
## (Q) Finished
q
## How many bits long is key?
$GPG_KEY_LENGTH
## When does key expire?
0
y
## Key user details
## Real name: 
$GPG_KEY_FULLNAME
## Email address: 
$GPG_KEY_EMAIL
## Comment: 
$GPG_KEY_COMMENT
##Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit?
o
## Save and exit
save
EOF-create-master-key
echo "#[${0##*/}]" "Reading keyid file"
KEYID="$(cat key-fingerprint.txt)"
echo "#[${0##*/}]" "KEYID=$KEYID"    



echo "#[${0##*/}]" "Create subkey: auth"
(   tee "dbg.create-subkey-auth.heredoc.txt" \
    | grep -v -e '^#' \
    | tee "dbg.create-subkey-auth.stripped.txt" \
    | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --expert --key-edit "$KEYID" \
    | tee "dbg.create-subkey-auth.gpg-stdout.txt"
) <<EOF-create-subkey-auth
# gpg>
addkey
# Please select what kind of key you want:
#    (8) RSA (set your own capabilities)
8
# Possible actions for a RSA key: Sign Encrypt Authenticate 
# Current allowed actions: Sign Encrypt 
#    (S) Toggle the sign capability
#    (E) Toggle the encrypt capability
#    (A) Toggle the authenticate capability
#    (Q) Finished
s
e
a
q
# RSA keys may be between 1024 and 4096 bits long.
# What keysize do you want? (3072)
$GPG_KEY_LENGTH
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-auth



echo "#[${0##*/}]" "Create subkey: sign"
(   tee "dbg.create-subkey-sign.heredoc.txt" \
    | grep -v -e '^#' \
    | tee "dbg.create-subkey-sign.stripped.txt" \
    | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --expert --key-edit "$KEYID" \
    | tee "dbg.create-subkey-sign.gpg-stdout.txt"
) <<EOF-create-subkey-sign
# gpg>
addkey
# Please select what kind of key you want:
#    (8) RSA (set your own capabilities)
8
# Possible actions for a RSA key: Sign Encrypt Authenticate 
# Current allowed actions: Sign Encrypt 
#    (S) Toggle the sign capability
#    (E) Toggle the encrypt capability
#    (A) Toggle the authenticate capability
#    (Q) Finished
e
q
# RSA keys may be between 1024 and 4096 bits long.
# What keysize do you want? (3072)
$GPG_KEY_LENGTH
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-sign



echo "#[${0##*/}]" "Create subkey: encrypt"
(   tee "dbg.create-subkey-encrypt.heredoc.txt" \
    | grep -v -e '^#' \
    | tee "dbg.create-subkey-encrypt.stripped.txt" \
    | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback  --passphrase="$key_passphrase" \
    --expert --key-edit "$KEYID" \
    | tee "dbg.create-subkey-encrypt.gpg-stdout.txt"
) <<EOF-create-subkey-encrypt
# gpg>
addkey
# Please select what kind of key you want:
#    (8) RSA (set your own capabilities)
8
# Possible actions for a RSA key: Sign Encrypt Authenticate 
# Current allowed actions: Sign Encrypt 
#    (S) Toggle the sign capability
#    (E) Toggle the encrypt capability
#    (A) Toggle the authenticate capability
#    (Q) Finished
s
q
# RSA keys may be between 1024 and 4096 bits long.
# What keysize do you want? (3072)
$GPG_KEY_LENGTH
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-encrypt


echo "#[${0##*/}]" "Done" "$(date +%Y-%m-%dT%H:%M:%S%z=@%s)]"
exit