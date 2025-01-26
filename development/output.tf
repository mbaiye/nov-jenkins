output "vpc_id" {
  value = aws_vpc.mobann_vpc.id
  
}

output "ec2-ip" {
  value = module.mobann_module.ec2-public-ip
  
}