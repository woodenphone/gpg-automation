# gpg_automation
My attempt at rigging GPG to be less of a hassle, largely using code by other people.


## NOTICE
This code is still a work-in-progress.

Expect many things to be broken at this point in time.

If you are an end-user, please instead refer to this guide which is much better: https://github.com/drduh/YubiKey-Guide


* Not tested for compatability with anything but linux distros that use apt (ex. raspbian).


Assumes these are how your system does things:
```
$ sudo apt install PACKAGE
$ sudo service NAME ACTION
```




## Installation
Clone this repo

`git clone THIS_REPOS_URL`



## Usage
See https://github.com/etsy/yubigpgkeyer/blob/master/README.md

`$ cd ./yubigpgkeyer/`

`$  python3 gpg_gener8.py --name "Fakename" --email "fake@example.com" --pin "123456" --newpin "swordfish" --adminpin "12345678" --newadminpin "love sex god" `


### Online phase
Installing packages

### Disconnect from networks
Keeping secrets secret.


### Offline phase
Key handling only occurs here


### Cleanup (Optional)
Removing private keys and other secrets.

## Doing it right
Probably plenty good enough for corporate or government work.

Run off a liveusb so that everything secret is confined to a flash drive.

Don't bother doing more than is practical for you, it's more important to have some security at all than parylize yourself keeping the mossad spooks out.


### Super paranoid
Only if really you care that much, but it's unlikey you need to go this far

Destroy your USB flash drive; microwave on high, incinerate, shred into powder, dump remaining ashes into the sea.




## License
Haha this is just to make things work, I'm not touching legal BS.

You're on your own, m8.