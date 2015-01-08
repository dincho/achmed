#!/bin/bash
sudo apt-get -y install software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get -y install ansible
cd /home/vagrant/achmed/provisioning
ansible-playbook -i inventary/dev --connection=local --limit devservers site.yml
