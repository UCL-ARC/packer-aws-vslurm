source "amazon-ebs" "rhel9-compute-node" {
  ami_name      = local.ami_name_compute_node
  instance_type = "t2.medium"
  region        = "eu-west-2"

  vpc_filter {
    filters = {
      "tag:Name" : "ARC-playpen"
    }
  }

  subnet_filter {
    filters = {
      "tag:Name" : "playpen-public-eu-west-2a"
    }
  }

  source_ami_filter {
    filters = {
      name                = "RHEL-9.2*-Access2-GP2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
      architecture        = "x86_64"
    }
    most_recent = true
    owners      = ["309956199498"] # Red Hat
  }

  ssh_username = var.username
}

build {
  name = local.ami_name_compute_node
  sources = [
    "source.amazon-ebs.rhel9"
  ]

  provisioner "shell" {
    environment_vars = [
      "NICKNAME=compute-node",
      "EPEL9_RPM_URL=https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm",
      "MUNGE_DIR=/etc/munge",
      "SLURM_DIR=/etc/slurm",
      "LOG_DIR=/var/log"
    ]
    scripts = [
      "./provisioner_scripts/aws-vslurm.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-cluster.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-cluster-compute-node.provisioner.sh"
    ]
  }
}
