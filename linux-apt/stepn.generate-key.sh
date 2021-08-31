#!/usr/bin/env bash
## stepn.generate-key.sh
##
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"


echo "#[${0##*/}]" "Load config"
# source 'config.sh'
sc_puk='12345678' # Smartcard admin PIN/PUK.
sc_pin='Eight-or-longer' # Smartcard User PIN.
key_passphrase='This-is-a-bad-1' # GPG secret key passphrase.
key_realname='Anonymous Faggot'
key_email='anonymous@example.com'
key_comment='This is an example key'



# echo "#[${0##*/}]" "Create master key"
# # Echo in any line not starting with hash character ('#')
# # Replace templating
# # Print restult to terminal
# # Give result to GPG
# # Take GPG's output, find keygrip, and store the keygrip to file
# # Load the keygrip from file to a variable
# grep -v -e '^#' "create_master_key.stdin" \
#     | sed "s/%%REALNAME%%/$key_realname/" \
#     | sed "s/%%EMAIL%%/$key_email/" \
#     | sed "s/%%COMMENT%%/$key_comment/" \
#     | tee /dev/tty \
#     | gpg --command-fd=0 \
#     --pinentry-mode=loopback  --passphrase="$key_passphrase" \
#     --expert --full-generate-key \
#     | perl -ne 'm/([A-Z0-9]+).rev/ ; print "$&"' \
#     | tee KEYID.txt
# KEYID="$(cat KEYID.txt)"
# echo "#[${0##*/}]" "KEYID=$KEYID"


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
    | tee KEYID.txt
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
4096
## When does key expire?
0
y
## Key user details
## Real name: 
$key_realname
## Email address: 
$key_email
## Comment: 
$key_comment
##Change (N)ame, (C)omment, (E)mail or (O)kay/(Q)uit?
o
## Save and exit
save
EOF-create-master-key
echo "#[${0##*/}]" "Reading keyid file"
KEYID="$(cat KEYID.txt)"
echo "#[${0##*/}]" "KEYID=$KEYID"    



echo "#[${0##*/}]" "Create subkey: auth"
(   grep -v -e '^#' "dbg.create-subkey-auth.heredoc.txt" \
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
4096
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-auth



echo "#[${0##*/}]" "Create subkey: sign"
(   grep -v -e '^#' "dbg.create-subkey-sign.heredoc.txt" \
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
4096
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-sign



echo "#[${0##*/}]" "Create subkey: encrypt"
(   grep -v -e '^#' "dbg.create-subkey-encrypt.heredoc.txt" \
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
4096
# Key is valid for? (0)
0
# Key does not expire at all
## Save and exit
save
EOF-create-subkey-encrypt



echo "#[${0##*/}]" "TODO: Verify key generation worked"
echo "#[${0##*/}]" "TODO: Verify master key"
echo "#[${0##*/}]" "TODO: Verify subkey: auth"
echo "#[${0##*/}]" "TODO: Verify subkey: sign"
echo "#[${0##*/}]" "TODO: Verify subkey: encrypt"


echo "#[${0##*/}]" "WIP: Export keys"
echo "#[${0##*/}]" "WIP: Export secret masterkey"
gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback  --passphrase="$key_passphrase" \
    --armor \
    --export-secret-keys $KEYID > $GNUPGHOME/mastersub.key

echo "#[${0##*/}]" "WIP: Export secret subkeys"
gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback  --passphrase="$key_passphrase" \
    --armor \
    --export-secret-subkeys $KEYID > $GNUPGHOME/sub.key



echo "#[${0##*/}]" "WIP: Make revokation certificate"
gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback  --passphrase="$key_passphrase" \
    --output $GNUPGHOME/revoke.asc \
    --gen-revoke $KEYID




echo "#[${0##*/}]" "WIP: Export public key"
gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --armor --export "$KEYID" > "$HOME/gpg-$KEYID-$(date +%F).pubkey.asc"



echo "#[${0##*/}]" "TODO: Export key stubs"



echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"

## See:
##> https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html#Unattended-GPG-key-generation