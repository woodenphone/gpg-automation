#!python3
##
##
## AUTHOR: Ctrl-S
## CREATED: 2021-08-19
## MODIFIED: 2021-08-19
# stdlib
import logging
import os
# pip3
import gnupg # https://bitbucket.org/vinay.sajip/python-gnupg/src/master/
# local modules

# Globals
PASSPHRASE='This-is-a-bad-1'
REALNAME='Anonymous Faggot'
EMAIL='anonymous@example.com'
COMMENT='This is an example key'


def main():
    ## Housekeeping
    logging.basicConfig(level=logging.DEBUG)
    logging.debug('Logging started')
    ## Prepare to work with GPG
    gpg = gnupg.GPG(gnupghome='/path/to/home/directory')
    ## Create master key
    logging.debug('Preparing parameters for main key')
    input_data = gpg.gen_key_input(
        key_type="RSA", key_length=4096, 
        expire_date=0, # 0 means never expire.
        name_real='Anonymous Faggot',
        name_email='anonymous@example.com',
        name_comment='This is an example key',
        passphrase='This-is-a-bad-1',
        )
    logging.debug('Generating main key')
    key = gpg.gen_key(input_data)



    ## Create subkeys
    logging.info(f'Finished')
    return

if __name__ == '__main__':
    main()