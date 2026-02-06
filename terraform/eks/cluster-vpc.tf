resource "aws_subnet" "gfp-cluster" {
  count = 2

  vpc_id            = var.vpc_id
  cidr_block        = element(["10.0.11.0/24", "10.0.12.0/24"], count.index)
  availability_zone = element(["${var.region}a", "${var.region}b"], count.index)

  tags = {
    Name = "eks-gfp-cluster-${count.index + 1}"
  }
}
