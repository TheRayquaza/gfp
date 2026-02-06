data "aws_ec2_managed_prefix_list" "cloudfront" {
  name = "com.amazonaws.global.cloudfront.origin-facing"
}

resource "aws_security_group_rule" "allow_cloudfront" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = [data.aws_ec2_managed_prefix_list.cloudfront.id]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group_rule" "allow_vpc_healthcheck" {
  type              = "ingress"
  from_port         = 80
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_cidr]
  security_group_id = aws_security_group.alb_sg.id
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
