source "amazon-ebs" "rhel9-configurer" {
  ami_name      = local.ami_name_configurer
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

  ssh_username = "ec2-user"
}

# server
build {
  name = local.ami_name_configurer
  sources = [
    "source.amazon-ebs.rhel9"
  ]

  provisioner "shell" {
    scripts = [
      "./provisioner_scripts/aws-vslurm.provisioner.sh",
      "./provisioner_scripts/aws-vslurm-configurer.provisioner.sh",
    ]
  }
}
