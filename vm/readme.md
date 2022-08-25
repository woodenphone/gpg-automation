# GPG automation demo VM README
This vagrant+ansible VM scripting is to allow rapid development without golden images or dedicated computers.

This is not designed for maximum security, just to develop and demonstrate the scripting.
For proper security you should do handling of secret keys offline.

## Prerequisites
Vagrant:
```

```

Ansible:
```
sudo dnf install ansible
```

Ansible dependancies:
```
ansible-galaxy install
```

## Configuration


## Usage
Create box
```
cd vm
vagrant up

```

Re-run provisioning of box:
```
vagrant provision
```

```
vagrant ssh
```

Destroy box:
```
vagrant destroy
```


