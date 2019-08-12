
# Default parameters can be specified in *.tfvars file
variable "access_key" {
  description = "Access key id for accessing to the account"
}
variable "secret_key" {
  description = "Secret key value for accessing to the account"
}
variable "instance_type" {
  description = "EC2 instance type"
}
variable "volume_size" {
  description = "Attached volume size to EC2 with GB"
}
variable "ssh_key_path" {
  description = "Private SSH key path. Relevant public key also should be located in the same path. Will be used to detect public also the public key by adding .pub to the end of the file "
}
variable "major_version" {
  description = "Major version of application"
}
variable "minor_version" {
  description = "Minor version/Build number of application"
}
variable "cuda_version" {
  description = "Cuda version"  
}
variable "cuDNN_version" {
  description = "CudNN version"  
}
variable "config_file" {
  description = "Custom config.toml file for application"
}
variable "region" {
  default = "eu-central-1"
  description = "Region where application will be launched"
}
variable "availability_zone" {
  default = "eu-central-1a"
  description ="AZ where application will be launched"
}
variable "name_tag" {
  description = "Name tag"
  default     = "h2o-dai"
}
