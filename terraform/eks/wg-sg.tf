resource "aws_security_group" "eks_ssh_access" {
  name        = "gfp-worker-ssh-access"
  description = "Allow SSH from my specific public IP"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from developer IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.local_workstation_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "gfp-ssh-access"
  }
}
