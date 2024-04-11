source "amazon-ebs" "rhel9-configurer" {
  ami_name      = local.ami_name_configurer
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
  name = local.ami_name_configurer
  sources = [
    "source.amazon-ebs.rhel9-configurer"
  ]

  provisioner "shell" {
    environment_vars = [
      "NICKNAME=configurer",
      "ANSIBLE_INVENTORY=/home/${var.username}/ansible_inventory",
      "REMOTE_USER=${var.username}"
    ]
    scripts = [
      "./provisioner_scripts/aws-vslurm.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-configurer.provisioner.sh",
    ]
  }
}
