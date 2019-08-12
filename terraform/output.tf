output "ip" {
  value = "${module.ec2Module.ec2_public_id}"
}
output "ssh-key-path" {
  value = "${module.ec2Module.ssh_key_path}"
}