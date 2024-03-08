#!/bin/bash -e

sudo dnf -yq install git python3-pip
pip install -q --no-input ansible

echo "export ANSIBLE_INVENTORY=$ANSIBLE_INVENTORY" >> /home/$REMOTE_USER/.bashrc
echo "export ANSIBLE_REMOTE_USER=$REMOTE_USER" >> /home/$REMOTE_USER/.bashrc
echo "export ANSIBLE_BECOME=True" >> /home/$REMOTE_USER/.bashrc
echo "export ANSIBLE_HOST_KEY_CHECKING=False" >> /home/$REMOTE_USER/.bashrc
