resource "aws_db_instance" "gfp_rds" {
  allocated_storage    = 20
  engine               = "postgres"
  db_name              = "gfpdb"
  instance_class       = "db.t3.micro"
  username             = "myusername"
  password             = "yoursecurepassword"
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.stats_db_subnet.name  
  multi_az             = false
}
