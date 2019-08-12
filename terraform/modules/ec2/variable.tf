# Variables

variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "name_tag" {}
variable "vpc_id" {}
variable "availability_zone" {}
variable "subnet_public_id" {}
variable "security_group_ids" {}
variable "instance_type" {}
variable "volume_size" {}
variable "ssh_key_path" {}
variable "instance_ami" {
  description = "EC2 instance ami"
  default = "ami-0badcc5b522737046"
}
variable "volume_type" {
  description = "Attached volume type to EC2"
  default = "gp2"
}
variable "install_dai" {
  description = "File for injection to user data for installation of DAI and launching with docker"
  default = "docker_install.sh"
}
