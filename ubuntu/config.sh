#!/usr/bin/env bash
## config.sh
## Define values to be imported into other scripts.
## sc_ means for the smartcard
## key_ means for actual GPG key

sc_puk='12345678' # Smartcard admin PIN/PUK.
sc_pin='Eight-or-longer' # Smartcard User PIN.

key_passphrase='This-is-a-bad-1' # GPG secret key passphrase.
key_realname='Anonymous Faggot'
key_email='anonymous@example.com'
key_comment='This is an example key'
