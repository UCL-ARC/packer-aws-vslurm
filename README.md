# packer-aws-vslurm
Packer templates for creating AMIs for vSlurm.

This template will initiate a Packer build that takes ~10 minutes and uses 6 t2.medium EC2 instances on AWS. It creates 6 EBS-backed AMIs and their associated snapshots. These resources may incur costs on your AWS account.

# Usage
1. Clone this repository
2. Configure your AWS credentials with the `awscli` (as advised [here](https://docs.aws.amazon.com/cli/latest/userguide/sso-configure-profile-token.html))
3. Install [Packer](https://developer.hashicorp.com/packer/tutorials/docker-get-started/get-started-install-cli)
4. Build the AMIs with the following commands:

```bash
cd packer
packer init .
packer build -var "vpc_name_filter=<YOUR_VPC_NAME>" -var "subnet_name_filter=<YOUR_SUBNET_NAME>" -var "source_rhel_ami_name_filter=<A_RHEL_AMI_NAME>" .
```
