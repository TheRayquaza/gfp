resource "aws_subnet" "gfp-cluster-workers" {
  count = 2

  vpc_id            = var.vpc_id
  cidr_block        = element(["10.0.3.0/24", "10.0.4.0/24"], count.index)
  availability_zone = element(["${var.region}a", "${var.region}b"], count.index)

  map_public_ip_on_launch = true # assign public IPs to instances launched in this subnet

  tags = {
    Name = "eks-gfp-cluster-${count.index + 1}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = "gfp-public-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = 2
  subnet_id      = aws_subnet.gfp-cluster-workers[count.index].id
  route_table_id = aws_route_table.public.id
}
