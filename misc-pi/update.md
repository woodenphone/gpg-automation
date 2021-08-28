# Updating raspbian
Mostly for reference purposes.

Raspbian uses apt for package management.

## Raspbian upgrade stretch to buster

To manually edit apt sources file:
```
$ sudo nano /etc/apt/sources.list
```

To backup a config file:
```
$ sudo cp /etc/apt/sources.list{,.t`date -u +%s`.backup}
```


Blind update of apt sources file but keep a backup of the original:
```
$ sudo sed -i.$(date -u +@%s).backup} -e's/stretch/buster/' '/etc/apt/sources.list'
```

Unattended upgrade: (testme)
```
#!/usr/bin/env bash
## Update to latest packages for current distro release
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoclean -y

## Change apt sources file to reference new distro release codename
sudo sed -i.$(date -u +@%s).backup} -e's/stretch/buster/' '/etc/apt/sources.list'

## Update to latest packages for current distro release
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoclean -y

## Restart machine 
sudo shutdown -r
```