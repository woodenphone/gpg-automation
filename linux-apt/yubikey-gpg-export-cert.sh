#!/usr/bin/env bash
## yubikey-gpg-export-cert.sh



## https://docs.yubico.com/software/yubikey/tools/ykman/OpenPGP_Commands.html#ykman-openpgp-certificates-export-options-key-certificate
ykman openpgp certificates export --format="PEM" sig "sig.pem"
ykman openpgp certificates export --format="PEM" enc "enc.pem"
ykman openpgp certificates export --format="PEM" aut "aut.pem"
ykman openpgp certificates export --format="PEM" att "att.pem"

