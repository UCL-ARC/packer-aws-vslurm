#!/bin/bash -e

sudo mkdir --mode 0755 /shared
sudo chown root:root /shared
sudo chmod 0755 /home
sudo chown root:root /home
sudo dnf -yq install nfs-utils
