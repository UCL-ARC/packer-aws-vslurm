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
  description = "A prefix to be applied to the new AMIs"
}

variable "username" {
  type    = string
  default = "ec2-user"
  description = "The username for the default user in the base image"
}

variable "vpc_name_filter" {
  type = string
  description = "A filter to identify the VPC to build the AMIs in"
}

variable "subnet_name_filter" {
  type = string
  description = "A filter to identify the subnet to build the AMIs in"
}

variable "source_rhel_ami_name_filter" {
  type = string
  description = "A filter to identify the name of the RHEL AMI to use as the base image"
}

locals {
  timestamp             = regex_replace(timestamp(), "[- TZ:]", "")
  ami_name_configurer   = "${var.ami_prefix}-configurer-${local.timestamp}"
  ami_name_server       = "${var.ami_prefix}-cluster-server-${local.timestamp}"
  ami_name_login        = "${var.ami_prefix}-cluster-login-${local.timestamp}"
  ami_name_database     = "${var.ami_prefix}-cluster-database-${local.timestamp}"
  ami_name_nfs_server   = "${var.ami_prefix}-cluster-nfs-server-${local.timestamp}"
  ami_name_compute_node = "${var.ami_prefix}-cluster-compute-node-${local.timestamp}"
}
