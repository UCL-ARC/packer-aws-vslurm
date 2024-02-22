#!/bin/bash -e

sudo dnf install -y $EPEL9_RPM_URL
sudo groupadd -g 201 munge
sudo groupadd -g 202 slurm
sudo useradd -u 201 -g munge --shell /sbin/nologin --no-create-home --system munge
sudo useradd -u 202 -g slurm --shell /sbin/nologin --no-create-home --system slurm
sudo mkdir --mode 0700 $MUNGE_DIR
sudo mkdir --mode 0755 $SLURM_DIR
sudo mkdir --mode 0755 $LOG_DIR/munge
sudo mkdir --mode 0755 $LOG_DIR/slurm
sudo dnf install -y munge slurm slurm-perlapi slurm-devel
