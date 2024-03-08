#!/bin/bash -e

sudo mkdir --mode 0755 /shared
sudo chown root:root /shared
sudo mkdir --mode 0755 -p /mnt/nfs/home
sudo chown root:root /mnt/nfs/home

sudo dnf -yq install slurm-contribs nfs-utils

sudo setsebool -P use_nfs_home_dirs on
