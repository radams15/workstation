#!/bin/bash

if [ "$1" == "" ]
then
    echo "Usage: $0 [IP]"
    exit 1
fi

ips=$1

shift

ansible-playbook -i "$ips," vim.yaml $@
