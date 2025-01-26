resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, 2 + count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true
  count = var.public_subnet_count

    tags = {
        Name = "mobann-public-subnet"
    }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(var.vpc_cidr_block, 8, count.index)
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false
  count = var.private_subnet_count

    tags = {
        Name = "mobann-private-subnet"
    }
}