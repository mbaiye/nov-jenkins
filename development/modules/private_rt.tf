resource "aws_eip" "eip_ngw" {
  domain = "vpc"

  tags = {
    Name = "mobann-ngw-eip"
  }
  
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip_ngw.id
  subnet_id = element(aws_subnet.public_subnet[*].id, 0)
  
  tags = {
    Name = "mobann-ngw"
  }
  
}

resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
    }

    tags = {
        Name = "mobann-private-route-table"
    }
}

resource "aws_route_table_association" "private_route_table_association" {
  count = var.private_subnet_count
  subnet_id = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
}