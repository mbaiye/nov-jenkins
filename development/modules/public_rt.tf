resource "aws_internet_gateway" "mobann_igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "mobann_igw"
  }
  
}

resource "aws_route_table" "mobann_public_route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mobann_igw.id
    }

    tags = {
        Name = "mobann-public-route-table"
    }
}

resource "aws_route_table_association" "mobann_public_route_table_association" {
  count = var.public_subnet_count
  subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.mobann_public_route_table.id
}