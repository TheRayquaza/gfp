
resource "aws_security_group" "db_sg" {
  name        = "db_sg"
  description = "Security group for RDS PostgreSQL"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    security_groups = var.eks_worker_sg_ids
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups = var.eks_worker_sg_ids
  } 
}
