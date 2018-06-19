#!/bin/sh
export ANSIBLE_HOST_KEY_CHECKING=False
sudo ansible-playbook -e 'host_key_checking=False' /home/ubuntu/Devops_Milestone1/itrust/postbuild.yml -vvv
