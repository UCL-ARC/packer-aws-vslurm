#!/bin/bash -e

sudo echo "export NICKNAME=$NICKNAME" > /etc/profile.d/prompt.sh
sudo echo "export PS1=\"[\$NICKNAME][\u@\h:\l \W]\\$ \"" >> /etc/bashrc

sudo dnf -y update
sudo dnf -y upgrade
sudo dnf -y install vim
