module "ec2Module" {
  source             = "./modules/ec2"
  access_key         = var.access_key
  secret_key         = var.secret_key
  region             = var.region
  availability_zone = var.availability_zone
  name_tag           = var.name_tag
  instance_type      = var.instance_type
  volume_size        = var.volume_size
  ssh_key_path    = var.ssh_key_path
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