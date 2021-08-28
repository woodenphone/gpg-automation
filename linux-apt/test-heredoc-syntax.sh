#!/usr/bin/env bash
## test-heredoc-syntax.sh
##
echo "#[${0##*/}]" "Start of script"  "[at $(date +%c,\ @%s)]"

echo "#[${0##*/}]" "Load config"
# source 'config.sh'
sc_puk='12345678' # Smartcard admin PIN/PUK.
sc_pin='Eight-or-longer' # Smartcard User PIN.
key_passphrase='This-is-a-bad-1' # GPG secret key passphrase.
key_realname='Anonymous Faggot'
key_email='anonymous@example.com'
key_comment='This is an example key'

OLD_ADMIN_PIN="12345678" # Yubikey default is '12345678'.
ADMIN_PIN="12345678"
OLD_RESET_CODE=""
RESET_CODE="reset-this"
OLD_USER_PIN="123456"
USER_PIN="123456" # Yubikey default is '123456'.


echo "## == == == =="
echo "#[${0##*/}]" "feed gpg heredoc"
( 
    tee "gpginput.heredoc" \
    | grep -v -e '^#' \
    | tee "gpginput.stripped" | tee /dev/tty \
    | gpg --command-fd=/dev/stdin --status-fd=/dev/stdout \
    --pinentry-mode=loopback --passphrase="$key_passphrase" \
    --card-edit
) <<EOF
##
admin
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
EOF



echo "## == == == =="
echo "#[${0##*/}]" "cat heredoc, remove comments, optionally suppress unused vars"
( 
    grep -v -e '^#' \
    | tee /dev/tty
) <<EOF2
4
${OLD_RESET_CODE}
${RESET_CODE}
## Set user code
1
## Optional thing
${OLD_RESET_CODE-#}
${RESET_CODE-#}
EOF2


echo "## == == == =="
echo "#[${0##*/}]" "really fucking complex inlining"
( 
    tee complex.heredoc \
    | grep -v -e '^#' \
    | tee complex.stripped
) <<EOF3
4
${OLD_RESET_CODE}
${RESET_CODE}
## Set user code
1
#
## Optional thing A
$({ if [[  -n $OLD_RESET_CODE || -n $RESET_CODE ]]; then { echo "4"; echo "${OLD_RESET_CODE}"; echo "${RESET_CODE}"; } else echo '# dummied out'; fi })
#
## Optional thing B
$({ if [[  -n $OLD_RESET_CODE && -n $RESET_CODE ]]; then { echo "4"; echo "${OLD_RESET_CODE}"; echo "${RESET_CODE}"; } else echo '# dummied out'; fi })
#
## Optional thing C
$({ if [[  -n $OLD_ADMIN_PIN ]]; then { echo "OLD_ADMIN_PIN=$OLD_ADMIN_PIN:"; } else echo '# dummied out'; fi })
EOF3


echo "## == == == =="
echo "#[${0##*/}]" "test if/else"
if [[  -n "$OLD_RESET_CODE" ||  -n "$RESET_CODE" ]] 
then {
    echo -n "4\n${OLD_RESET_CODE}\n${RESET_CODE}\n"
}
else { 
    echo -n '#' 
}
fi 

echo "## == == == =="
echo "#[${0##*/}]" "End of script"  "[at $(date +%c,\ @%s)]"