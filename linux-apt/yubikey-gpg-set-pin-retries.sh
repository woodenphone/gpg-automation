#!/usr/bin/env bash
## yubikey-gpg-set-pin-retries.sh
## Example of setting yubikey maximum attempt counters.
##
## Usage: ykman openpgp set-pin-retries [OPTIONS] PIN-RETRIES RESET-CODE-RETRIES ADMIN-PIN-RETRIES
##
# ykman openpgp set-pin-retries --admin-pin="${code_admin}" "${n_pin}" "${n_reset}" "${n_admin}"

## Interactively ask for admin passcode, set maximum allowed attempts to 10 for all three codes.
ykman openpgp set-pin-retries  10 10 10