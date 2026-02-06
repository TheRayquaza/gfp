resource "aws_subnet" "main-rds" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "Main-RDS-Subnet"
  }
}

resource "aws_subnet" "backup-rds" {
  vpc_id            = var.vpc_id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "Backup-RDS-Subnet"
  }
}

resource "aws_db_subnet_group" "stats_db_subnet" {
  name       = "db-subnet-group"
  subnet_ids = [aws_subnet.main-rds.id, aws_subnet.backup-rds.id]

  tags = {
    Name = "My DB Subnet Group"
  }
}
