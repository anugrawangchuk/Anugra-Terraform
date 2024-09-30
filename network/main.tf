# VPC for JFrog
resource "aws_vpc" "jfrog_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.vpc_tenancy
  tags = {
    Name = var.vpc_name
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.jfrog_vpc.id
  cidr_block        = var.pub_cidr
  availability_zone = "${var.aws_region}a" # Choose one availability zone
  tags = {
    Name = var.pub_sub_name
  }
}

# Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.jfrog_vpc.id
  cidr_block        = var.pvt_cidr
  availability_zone = "${var.aws_region}a" # Same availability zone as public
  tags = {
    Name = var.pvt_sub_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.jfrog_vpc.id
  tags = {
    Name = var.igw_name
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_gtw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = var.nat_name
  }

  depends_on = [aws_internet_gateway.igw]
}

# Public Route Table
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.jfrog_vpc.id
  route {
    cidr_block = var.default_route_cidr_block
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.pub_rt_name
  }
}

# Private Route Table
resource "aws_route_table" "pvt_rt" {
  vpc_id = aws_vpc.jfrog_vpc.id
  route {
    cidr_block     = var.default_route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_gtw.id
  }
  tags = {
    Name = var.pvt_rt_name
  }
}

# Route Table Associations
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.pvt_rt.id
}

# VPC Peering (optional)
resource "aws_vpc_peering_connection" "vpc_peering" {
  vpc_id      = var.peering_vpc_id
  peer_vpc_id = aws_vpc.jfrog_vpc.id
  auto_accept = var.auto_accept_peering

  tags = {
    Name = var.vpc_peering_name
  }
}

# Route for VPC Peering
resource "aws_route" "Existing_route" {
  route_table_id            = var.route_table_id
  destination_cidr_block    = var.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
  depends_on = [aws_vpc_peering_connection.vpc_peering]
}
