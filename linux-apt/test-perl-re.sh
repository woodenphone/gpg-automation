#!/usr/bin/env bash
## test-perl-re.sh
## Develop perl (PCRE) regex stuff
echo "#[${0##*/}]" "== Start ==" "[at $(date +%c,\ @%s)]"


echo "#[${0##*/}]" "Expect: 1F44311A8C50EEEC"
(   
    tee /dev/null \
    | perl -ne 'print "$1\n" if m/^gpg: key ([A-Z0-9]+) marked as ultimately trusted/;'
) <<EOF-trusted
We need to generate a lot of random bytes. It is a good idea to perform
some other action (type on the keyboard, move the mouse, utilize the
disks) during the prime generation; this gives the random number
generator a better chance to gain enough entropy.                  
gpg: key 1F44311A8C50EEEC marked as ultimately trusted               
gpg: revocation certificate stored as '/home/pi/.gnupg/openpgp-revocs.d/CA3A6DB3797A83C9114AE0631F44311A8C50EEEC.rev'
public and secret key created and signed.   
EOF-trusted

echo "#[${0##*/}]" "Expect: 1F44311A8C50EEEC"
echo 'gpg: key 1F44311A8C50EEEC marked as ultimately trusted' | perl -ne 'print "$1\n" if m/^gpg: key ([A-Z0-9]+) marked as ultimately trusted/;'

echo "#[${0##*/}]" "== Finish ==" "[at $(date +%c,\ @%s)]"