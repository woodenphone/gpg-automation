#!/usr/bin/env bash
## yubikey-require-touch.sh
## Configure yubikey smartcard to require touch.
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"


# ykman openpgp touch aut on
# ykman openpgp touch sig on
# ykman openpgp touch enc on



# Help: ykman openpgp set-touch -h

ykman openpgp set-touch --admin-pin="${admin_code}" sig on
ykman openpgp set-touch --admin-pin="${admin_code}" enc on
ykman openpgp set-touch --admin-pin="${admin_code}" aut on
ykman openpgp set-touch --admin-pin="${admin_code}" att on


echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"
##
## https://developers.yubico.com/yubikey-manager/
## https://docs.yubico.com/software/yubikey/tools/ykman/Using_the_ykman_CLI.html
## https://docs.yubico.com/software/yubikey/tools/ykman/Base_Commands.html#ykman-config-usb-options
##