#!/bin/sh

if [ `id -u` -ne 0 ]
then
	echo "Please run as root!"
	exit 1
fi

#ansible-galaxy collection install -r requirements.yaml
ansible-playbook local.yaml
