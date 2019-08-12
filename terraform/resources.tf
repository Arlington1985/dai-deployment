module "ec2Module" {
  source             = "./modules/ec2"
  access_key         = var.access_key
  secret_key         = var.secret_key
  region             = var.region
  availability_zone = var.availability_zone
  name_tag           = var.name_tag
  instance_type      = var.instance_type
  volume_size        = var.volume_size
  ssh_key_path       = var.ssh_key_path
  major_version      = var.major_version
  minor_version      = var.minor_version
  cuda_version       = var.cuda_version
  cuDNN_version      = var.cuDNN_version
  config_file        = var.config_file
  vpc_id             = module.vpcModule.vpc_id
  subnet_public_id   = module.vpcModule.public_subnets[0]
  security_group_ids = [module.ec2Module.dai_sg]
}

module "vpcModule" {
  source            = "./modules/vpc"
  access_key        = var.access_key
  secret_key        = var.secret_key
  region            = var.region
  availability_zone = var.availability_zone
  name_tag          = var.name_tag
}