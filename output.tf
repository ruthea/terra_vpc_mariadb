output "bastion.ip" {
  value = ["${aws_instance.bastion.*.public_ip}"]
}
output "bastion.dns" {
  value = ["${aws_instance.bastion.*.public_dns}"]
}
