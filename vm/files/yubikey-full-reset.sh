#!/bin/bash
## yubikey-full-reset.sh
## Reset a yubikey completely.
## Requires user to touch the key.
echo "#[${0##*/}]" "Resetting yubikey completely"

echo "Erasing Yubikey FIDO (Requires touch)"
ykman fido reset --force

echo "Erasing Yubikey OATH"
ykman oath reset --force

echo "Erasing Yubikey OTP"
ykman otp delete --force 1
ykman otp delete --force 2

echo "Erasing Yubikey PIV"
ykman piv reset --force

echo "Erasing Yubikey OpenPGP"
ykman openpgp reset --force

echo "Erasing Yubikey config lock code"
ykman config set-lock-code --clear --force

echo "#[${0##*/}]" "Done"
exit