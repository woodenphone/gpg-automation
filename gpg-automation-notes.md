# Automating GPG





Take commands from stdin, waiting/blocking when not taking input.
`--command-fd=0`

Convenient script file:
```
$ grep -v -e '^#' "add_subkey.A.stdin" | gpg --command-fd=0...
```

From string:
```
$ gpg --command-fd=0... < "keytocard\nsave\n"
```

Take a passphrase from the command line
`--pinentry-mode=loopback --passphrase="This-is-a-bad-1"`

```
grep -v -e '^#' "add_subkey.A.stdin" |\
    gpg --command-fd=0 \
    --pinentry-mode=loopback \
    --passphrase="This-is-a-bad-1" --expert \
    --key-edit "D1BF1A526D96A48A5582518624567BEC73673A51"
```

Use a file with templates, so config can be all in one place
```
sed INPUT_FILE | 
```