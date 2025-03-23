#!/bin/bash

# Simple script to check if Ansible is installed and install it if not
echo "Checking if Ansible is installed..."

if command -v ansible &> /dev/null; then
    echo "Ansible is already installed."
else
    sudo apt install -y ansible
fi

ansible-playbook $HOME/.config/ansible/bootstrap.yaml -K

