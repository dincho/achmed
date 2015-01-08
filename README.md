Achmed
======

Symfony skeleton

## Development environment setup

- [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Install Vagrant](https://docs.vagrantup.com/v2/installation/)
- [Install Ansible](http://docs.ansible.com/intro_installation.html)

```bash
vagrant plugin install vagrant-hostmanager vagrant-rsync-back
```

```bash
git clone git@github.com:dincho/achmed.git
cd achmed
vagrant up
```

## Sync

rsync-back copy files from guest to host machine, you need to run this command very rate, 
e.g. when bower or composer vendors are updated

rsync-auto copy files from host to guest machine, it's running until CTRL+C, 
so when you edit files in your host machine editor, it's auto-synced

```bash
vagrant rsync-back
vagrant rsync-auto
```

## Winboze users

- [Install Cygwin with rsync](https://www.cygwin.com)
- Change cygwin prefix like ```none / cygdrive binary,posix=0,user 0 0```
- You may need to change the ```vagrant``` password if you have issues with the public key and SQL clients tunneling
