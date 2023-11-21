#!/bin/sh

ansible-galaxy collection install -r requirements.yaml

if [ "$1" != "" ]
then
    ansible-playbook local.yaml --tags "$1"
else
    ansible-playbook local.yaml
fi
