    
provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}
data "template_file" "user_data" {
  template = "${file("${path.module}/docker_install.sh")}"
  vars = {
    major_version = "${var.major_version}"
    minor_version = "${var.minor_version}"
    cuda_version  = "${var.cuda_version}"
    cuDNN_version = "${var.cuDNN_version}"
    config_file   = "${var.config_file}"
  }
}
resource "aws_instance" "instance" {
  ami           = "${var.instance_ami}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.subnet_public_id}"
  vpc_security_group_ids = "${var.security_group_ids}"
  root_block_device {
    volume_size = "${var.volume_size}"
    volume_type = "${var.volume_type}"
    delete_on_termination = true
  }
  key_name = "${aws_key_pair.key_pair.key_name}"
  user_data = "${data.template_file.user_data.rendered}"

  provisioner "file" {
    content      = "${var.config_file != "" ? file(var.config_file) : "no_config"}"
    destination = "${var.config_file != "" ? "/tmp/config.toml" : "/tmp/no_config"}"
  }
  provisioner "remote-exec" {
    inline = [
       "tail -f /var/log/cloud-init-output.log | sed '/Welcome to H2O.ai/q'"
    ]
  }
  connection {
    type        = "ssh"
    host        = "${aws_instance.instance.public_ip}" 
    user        = "ec2-user"
    private_key = "${file(var.ssh_key_path)}"
  }
  tags = {
    Name = "${var.name_tag}"
  }
}
resource "aws_security_group" "dai_sg" {
  name = "dai_sg"
  vpc_id = "${var.vpc_id}"

  ingress {
      from_port   = 12345
      to_port     = 12345
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name_tag}"
  }
}
resource "aws_key_pair" "key_pair" {
  key_name = "h2o-dai"
  public_key = "${file("${var.ssh_key_path}.pub")}"
}
