#!/usr/bin/env bash
## learn-smartcard.sh
## Get GPG to associate a key it has with an attached smartcard.
## SEE: https://github.com/drduh/YubiKey-Guide#using-multiple-keys
gpg-connect-agent "scd serialno" "learn --force" /bye
