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

- Make sure you have working ```ssh``` and ```rsync``` commands. Can be installed with [Cygwin](https://www.cygwin.com). Don't forget to add cygwin bin directory to PATH environment variable.
- Change cygwin prefix in ```/path/to/cygwin/etc/fstab``` like ```none / cygdrive binary,posix=0,user 0 0```
- You may need to change the ```vagrant``` password if you have issues with the public key and SQL clients tunneling

## Setup new project

- Edit ```PROJECT_NAME``` in Vagrantfile
- Edit ```name``` in bower.json
- Edit ```project_name``` in provisioning/group_vars/all/vars
- Edit provisioning/inventary/dev to reflect your archirecture inventary
- Copy provisioning/group_vars/all/secrets.dist to provisioning/group_vars/all/secrets and update it to configure your project specifics

## Deploy

cd /path/to/project/provisioning
RELEASE_VERSION=`date -u +%Y%m%d%H%M%S`
ansible-playbook -i inventary/dev release.yml --extra-vars="version=$RELEASE_VERSION project_source_path=/absolute/path/to/project/"
