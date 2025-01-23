output "nginx_public_ip" {
  value       = aws_instance.ec2_public.public_ip
  description = "The public IP address of the ec2 instance."
}

output "nginx_eip" {
  value       = aws_eip.ec2_public.public_ip
  description = "EIP address of the ec2 instance."
}
