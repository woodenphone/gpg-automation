#!/usr/bin/env bash
## gpg-learn-correct.sh
## Learn the correct smartcard. By any means necissary.

#gpg-connect-agent "scd serialno" "learn --force" /bye
CORRECT_SERIAL_NUMBERS=(
    ""
    ""
)

pcsc_scan -n -t 5