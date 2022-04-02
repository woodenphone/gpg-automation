# Notes about yubikey smartcards
## Buying advice
* Advice as of 2022-JAN
Get a yubikey 5.

The plain 5 supports the most protocols. Many of the other varieties won't do openpgp.

"YubiKey 5 NFC" - Size of a key, can talk to your phone over NFC.
Good if you want it on your keyring.
(On the go)

"YubiKey 5 Nano" - Fits aproximately flush inside a USB port. Nice for machines where you don't want to knock it loose.
(If it's always going to be in one machine)

You will want to thread a string through to eyelet to make it easier to remove from the port. Otherwise be ready to use a bent paperclip to pull it instead.

Buy the little keyring strap cord, it's worth it for the convenience.
You can get the eyelet loop strap things in bulk (e.g. 50x) for cheap if you care to.

A keyring tag or some masking tape is very helpful for keeping track of the dongle's purpose.


## Factory reset
TODO: CLI and GUI methods.

## cusomization GUI
TODO: There are two different ones.


## ykman (commandline config tool)
https://docs.yubico.com/software/yubikey/tools/ykman/index.html

Install ykman:
```
$ pip install --user yubikey-manager
```
https://docs.yubico.com/software/yubikey/tools/ykman/Install_ykman.html

Show version of installed ykman:
```
$ ykman -v
```

List connected yubikeys:
```
$ ykman list
```

Show help:
```
$ ykman -h
$ ykman openpgp -h
```
When in doubt, try checking for command-specific help.


### Configure NFC (ykman)
https://docs.yubico.com/software/yubikey/tools/ykman/Base_Commands.html

List NFC enabled applications:
```
$ ykman config nfc --list
```

Disable NFC for all applications:
```
$ ykman config nfc --disable-all
```

Enable NFC for all applications:
```
$ ykman config nfc --enable-all
```

### Configure USB (ykman)
https://docs.yubico.com/software/yubikey/tools/ykman/Base_Commands.html

List USB enabled appliactions:
```
$ ykman config usb --list
```

### Troubleshooting / fixes (ykman)
#### ykman hangs
Symptoms: ykman hangs, ^c does not terminate it.

Solution: Restart smartcard daemon:
```
$ sudo systemctl restart pcscd
```

