#!python3
import logging
import os
import subprocess
import re

NUMERALS = '0123456789'


def check_patterns(testee:str, pats:list=[]):
    for pat in allowed_pats:
        if re.search(pat, testee):
            return True
    return False

def check_serials(serials:str, pats:list=[]):
    for serial in serials:
        if check_patterns(serials=serials, pats=pats)
            return serial
    return None


def query_serial(reader):
    """Get the serial number from a specific reader"""
    return sc_serial

def detect_readers():
    """Look for smartcard readers"""
    args_detect_readers=[ 'pcsc_scan', # Executable
        '-r', # only lists readers
    ]
    logging.debug(f'args_detect_readers={args_detect_readers!r}')
    res = subprocess.run(args=args,)
    readers = []
    for line in res.stdout:
        if line[0] in NUMERALS:
            readers.append(line)
    logging.debug(f'readers={readers!r}')
    return readers


def learn_reader(reader):
    """Learn the specified smartcard"""
    ## gpg-connect-agent "scd serialno" "learn --force" /bye
    args_learn=[ 'gpg-connect-agent', # Executable
        'scd serialno', # Ask smartcard daemon for a serial
        'learn --force', ## Learn the serial
        '/bye', # Hangup
    ]
    logging.debug(f'args_learn={args_learn!r}')
    res = subprocess.run(args=args,)


def main():
    ## Define correct serial number(s)
    ## Enumerate readers
    readers = detect_readers()
    ## Poll each reader for serial number
    for reader in readers:
        serial = query_serial(reader)
        if serial in allowed_serials:

    return

if __name__ == '__main__':
    main()