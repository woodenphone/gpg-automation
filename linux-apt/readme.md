# Readme for linux + apt
(This is currently primarily for me to remember how to use this.)


## Testing steps
via `$ ssh THE_TEST_MACHINE_HERE`:
```
$ byobu
$ ls -lahQ
$ sudo whoami # To allow later sudo usage to skip password.

$ sudo apt-get update && sudo apt-get upgrade -y
$ bash step01-online.sh

$ bash stepn.generate-key.sh
```

## Fixing apt