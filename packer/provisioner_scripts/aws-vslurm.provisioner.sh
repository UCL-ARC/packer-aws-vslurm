#!/bin/bash -e

sudo echo "export NICKNAME=$NICKNAME" | sudo tee /etc/profile.d/prompt.sh > /dev/null
sudo echo "export PS1=\"[\$NICKNAME][\u@\h:\l \W]\\$ \"" | sudo tee --append /etc/bashrc > /dev/null

sudo dnf -y update
sudo dnf -y upgrade
sudo dnf -y install vim
