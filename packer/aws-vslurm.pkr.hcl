packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "ami_prefix" {
  type    = string
  default = "vslurm"
}

locals {
  timestamp             = regex_replace(timestamp(), "[- TZ:]", "")
  ami_name_configurer   = "${var.ami_prefix}-configurer-${local.timestamp}"
  ami_name_server       = "${var.ami_prefix}-cluster-server-${local.timestamp}"
  ami_name_login        = "${var.ami_prefix}-cluster-login-${local.timestamp}"
  ami_name_database     = "${var.ami_prefix}-cluster-database-${local.timestamp}"
  ami_name_nfs_server   = "${var.ami_prefix}-cluster-nfs-server-${local.timestamp}"
  ami_name_compute_node = "${var.ami_prefix}-cluster-nfs-compute-node-${local.timestamp}"
}
