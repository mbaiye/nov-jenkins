resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id
  name = "jenkins_sg"
  description = "Allow inbound traffic to Jenkins"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
}

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "jenkins_sg"
    }   

}
resource "aws_instance" "jenkins" {
    ami = "ami-02c6f9d4d56ecd64e"
    instance_type = "t3.medium"
    subnet_id = element(aws_subnet.public_subnet[*].id, 0)
    vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
    associate_public_ip_address = true
    tags = {
        Name = "jenkins"
    }
    
    root_block_device {
        volume_size = 50
        volume_type = "gp3"
        delete_on_termination = true
    }
}

output "ec2-public-ip" {
    value = aws_instance.jenkins.public_ip
  
}