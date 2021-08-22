#!/usr/bin/env bash
## ubuntu.stepn.generate-key.sh
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



# echo "#[${0##*/}]" "Create primary key"
# gpg  --batch \
#     --pinentry-mode=loopback \
#     --algo=rsa \
#     --passphrase="$key_passphrase" \
#     --expire=never \
#     --quick-gen-key

# gpg  --batch --pinentry-mode=loopback --passphrase='This-is-a-bad-1' --quick-gen-key 'Anonymous Faggot' 'rsa' 'encrypt,sign,auth' 'never'

# gpg  --batch --pinentry-mode=loopback --passphrase='This-is-a-bad-1' --full-generate-key 'Anonymous Faggot' 'rsa' 'encrypt,sign,auth' 'never'

# gpg  --batch --pinentry-mode=loopback --passphrase="This-is-a-bad-1" --expert --full-generate-key 'Anonymous Faggot' 'rsa' 'encrypt,sign,auth' 'never'

# gpg  --batch --pinentry-mode=loopback --passphrase="This-is-a-bad-1" --expert --full-generate-key 'Anonymous Faggot' 'rsa' 'none' 'never'


echo "#[${0##*/}]" "Create master key"
# Echo in any line not starting with hash character ('#')
# Replace templating
# Print restult to terminal
# Give result to GPG
# Take GPG's output, find keygrip, and store the keygrip to file
# Load the keygrip from file to a variable
grep -v -e '^#' "create_master_key.stdin" \
    | sed "s/%%REALNAME%%/$key_realname/" \
    | sed "s/%%EMAIL%%/$key_email/" \
    | sed "s/%%COMMENT%%/$key_comment/" \
    | tee /dev/tty \
    | gpg --command-fd=0 \
    --pinentry-mode=loopback  --passphrase="$key_passphrase" \
    ---expert --full-generate-key \
    | perl -ne 'm/([A-Z0-9]+).rev/ ; print "$&"' \
    | tee KEYID.txt
KEYID="$(cat KEYID.txt)"
echo "#[${0##*/}]" "KEYID=$KEYID"





## gpg: revocation certificate stored as '/home/ctrls/.gnupg/openpgp-revocs.d/34A1640DE2F068A5CE550299C4E4C2BF36FCD98D.rev'
## Capture keygrip
# grep -P -e"^gpg: revocation certificate stored as .+/[:alnum:].rev'$"
# perl -pe 'print "$&\n" if
# s/\/[A-Z0-9].rev/[emailaddr]/g' | tee keygrip
# keygrip="$(cat keygrip)"

# echo "gpg: revocation certificate stored as '/home/ctrls/.gnupg/openpgp-revocs.d/34A1640DE2F068A5CE550299C4E4C2BF36FCD98D.rev'" | perl -pe 'print "$&\n" if m|^gpg: revocation certificate stored as.+/([A-Z0-9]).rev|'

# echo "gpg: revocation certificate stored as '/home/ctrls/.gnupg/openpgp-revocs.d/34A1640DE2F068A5CE550299C4E4C2BF36FCD98D.rev'" | perl -ne 'm/([A-Z0-9]+).rev/ ; print "$&"' | tee keygrip.txt


# gpg --batch --pinentry-mode=loopback --passphrase="This-is-a-bad-1" --expert --full-generate-key --verbose <<EOF
# 8
# q
# 4096
# 0
# y
# Anonymous Faggot
# anonymous@example.com
# This is an example key
# o
# EOF

echo "#[${0##*/}]" "Create subkey: auth"
# Echo in any line not starting with hash character ('#')
grep -v -e '^#' "add_subkey.A.stdin" |\
    gpg --command-fd=0 \
    --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --expert \
    --key-edit "$KEYID" 

echo "#[${0##*/}]" "Create subkey: sign"
grep -v -e '^#' "add_subkey.S.stdin" |\
    gpg --command-fd=0 \
    --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --expert \
    --key-edit "$KEYID" 

echo "#[${0##*/}]" "Create subkey: encrypt"
grep -v -e '^#' "add_subkey.E.stdin" |\
    gpg --command-fd=0 \
    --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --expert \
    --key-edit "$KEYID" 


echo "#[${0##*/}]" "Verify key generation worked"
## TODO
echo "#[${0##*/}]" "Verify master key"
## TODO
echo "#[${0##*/}]" "Verify subkey: auth"
## TODO
echo "#[${0##*/}]" "Verify subkey: sign"
## TODO
echo "#[${0##*/}]" "Verify subkey: encrypt"
## TODO


echo "#[${0##*/}]" "Export secret keys"
## WIP
gpg --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --armor \
    --export-secret-keys $KEYID > $GNUPGHOME/mastersub.key

gpg --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --armor \
    --export-secret-subkeys $KEYID > $GNUPGHOME/sub.key



echo "#[${0##*/}]" "Make revokation certificate"
## WIP
gpg --pinentry-mode=loopback \
    --passphrase="$key_passphrase" \
    --output $GNUPGHOME/revoke.asc \
    --gen-revoke $KEYID




echo "#[${0##*/}]" "Export public key"
gpg --armor --export "$KEYID" > "$HOME/gpg-$KEYID-$(date +%F).pubkey.asc"

echo "#[${0##*/}]" "Export key stubs"
## TODO











# echo "#[${0##*/}]" "Create subkeys"
# gpg  --batch \
#     --pinentry-mode=loopback \
#     --usage='auth'
#     --expire=never \
#     --quick-add-key



echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"

## See:
##> https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html#Unattended-GPG-key-generation