#!/usr/bin/env bash
## ubuntu.stepn.keytocard.sh
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


KEYID="$(cat KEYID.txt)"
echo "#[${0##*/}]" "KEYID=$KEYID"

echo "#[${0##*/}]" "Note:"
echo "# Extra procedures for reliability when programming multiple smartcards"
echo "# keytocard breaks the copy of the key held by gpg as it moves rather than copies the key"  
echo "# as a result, keys must be:"
echo "# 1. Backed up to file."
echo "# 2. Written to card."
echo "# 3. Pointers/stubs saved."
echo "# 4. Cleared from GPG."
echo "# 5. Restored from file, with proper trust level granted."
echo ""

echo "#[${0##*/}]" "Backup keys"
rm -vrf $GNUPGHOME.scbkup
mv -vi $GNUPGHOME $GNUPGHOME.scbkup


echo "#[${0##*/}]" "Erase smartcard and set retry limits"
ykman openpgp reset


echo "#[${0##*/}]" "Set retry limits for smartcard"
ykman openpgp access set-retries 5 5 5


echo "#[${0##*/}]" "Program PINs onto smartcard"
(   tee "dbg.cardedit.heredoc" \
    | grep -v -e '^#' \
    | tee "dbg.cardedit.stripped" | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --card-edit
) <<EOF-cardedit
## enable admin commands
admin
## Enter password menu
passwd
## Set admin code
3
${OLD_ADMIN_PIN}
${ADMIN_PIN}
## Set reset code
4
${OLD_RESET_CODE}
${RESET_CODE}
## Set user code
1
${OLD_USER_PIN}
${USER_PIN}
## Exit password menu
q
## Exit card editing
quit
EOF-cardedit


echo "#[${0##*/}]" "Program keys onto smartcard"
(   tee "dbg.keytocard.heredoc" \
    | grep -v -e '^#' \
    | tee "bg.keytocard.stripped" | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --key-edit "$KEYID" 
) <<EOF-keytocard
# gpg>
## Deselect all keys
key 0
#
## Subkey 1 of 3 (signing)
key 0
key 1
keytocard
1
#
## Subkey 2 of 3 (encryption)
key 0
key 2
keytocard
2
#
## Subkey 3 of 3 (authentication)
key 0
key 3
keytocard
3
#
## Exit
save
EOF-keytocard



# echo "#[${0##*/}]" "Write key stubs to file"



# echo "#[${0##*/}]" "Remove keys"
# gpg --delete-secret-and-public-keys "$KEYID"


# echo "#[${0##*/}]" "Load keys"


# echo "#[${0##*/}]" "Assign trust to keys"


echo "#[${0##*/}]" "Restore keys"
rm -vrf $GNUPGHOME
mv -vi $GNUPGHOME.scbkup $GNUPGHOME



echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"

## See:
##> https://www.gnupg.org/documentation/manuals/gnupg/Unattended-GPG-key-generation.html#Unattended-GPG-key-generation