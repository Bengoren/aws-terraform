output "instance_public_ip" {
  description = "Public IP of the deployed EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}

output "ssh_access" {
  description = "SSH Access Instructions"
  value       = "ssh ec2-user@${aws_instance.my_ec2.public_ip}"
}
