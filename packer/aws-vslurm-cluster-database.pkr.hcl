source "amazon-ebs" "rhel9-database" {
  ami_name      = local.ami_name_database
  instance_type = "t2.medium"
  region        = "eu-west-2"

  vpc_filter {
    filters = {
      "tag:Name" : var.vpc_name_filter
    }
  }

  subnet_filter {
    filters = {
      "tag:Name" : var.subnet_name_filter
    }
  }

  source_ami_filter {
    filters = {
      name                = var.source_rhel_ami_name_filter 
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
  name = local.ami_name_database
  sources = [
    "source.amazon-ebs.rhel9-database"
  ]

  provisioner "shell" {
    environment_vars = [
      "NICKNAME=database",
      "EPEL9_RPM_URL=https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm",
      "MUNGE_DIR=/etc/munge",
      "SLURM_DIR=/etc/slurm",
      "LOG_DIR=/var/log"
    ]
    scripts = [
      "./provisioner_scripts/aws-vslurm.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-cluster.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-cluster-database.provisioner.sh"
    ]
  }
}
