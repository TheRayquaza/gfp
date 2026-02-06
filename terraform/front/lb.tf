resource "random_password" "custom_header_token" {
  length  = 32
  special = false
}

resource "aws_lb" "ingress_alb" {
  name = "eks-shared-alb"
  subnets = [ for subnet in aws_subnet.gfp-public-subnet : subnet.id ]
}

resource "aws_subnet" "gfp-public-subnet" {
  count = 2

  vpc_id            = var.vpc_id
  cidr_block        = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(["${var.region}a", "${var.region}b"], count.index)

  tags = {
    Name = "eks-gfp-cluster-${count.index + 1}"
  }
}
