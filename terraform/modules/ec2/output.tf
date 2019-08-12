output "dai_sg" {
  value = "${aws_security_group.dai_sg.id}"
}
output "ec2_public_id" {
  value = "${aws_instance.instance.public_ip}"
}
output "ssh_key_path" {
  value = "${var.ssh_key_path}"
}
