#!/bin/bash
## forget-key.sh
## Make GPG forget some specified key.
$FINGERPRINT=$1
echo "#[${0##*/}]" "argv:" "$( builtin printf '"%q" ' "$@[@]" )" | tee "dbg.${0##*/}.argv.txt" ## Print variable shell-quoted.

echo "#[${0##*/}]" "Forgetting key with fingerprint: ${FINGERPRINT}"

gpg_args=(
  --command-fd=/dev/stdin
  --status-fd=/dev/stdout
  --yes ## Don't ask for confirmation.
  --delete-secret-and-public 
  "${FINGERPRINT}"
  ## https://www.gnupg.org/documentation/manuals/gnupg/Operational-GPG-Commands.html#Operational-GPG-Commands
)
echo "#[${0##*/}]" "gpg_args:" "$( builtin printf '"%q" ' "$gpg_args[@]" )" | tee "dbg.${0##*/}.gpg-args.txt" ## Print variable shell-quoted.

gpg gpg_args[@] | tee "dbg.${0##*/}.gpg-stdout.txt"

echo "#[${0##*/}]" "Done"
exit
