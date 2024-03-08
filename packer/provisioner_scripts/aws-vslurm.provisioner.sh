#!/bin/bash -e

sudo echo "export NICKNAME=$NICKNAME" | sudo tee /etc/profile.d/prompt.sh > /dev/null
sudo echo "export PS1=\"[\$NICKNAME][\u@\h:\l \W]\\$ \"" | sudo tee --append /etc/bashrc > /dev/null

sudo dnf -yq update
sudo dnf -yq upgrade
sudo dnf -yq install vim
