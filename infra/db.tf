resource "aws_db_subnet_group" "demo_dbsubnet" {
  name       = "main"
  subnet_ids = toset([
    aws_subnet.prv_sub1.id,
    aws_subnet.prv_sub2.id,
  ])

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "PsqlForLambda" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "postgres"
  instance_class       = "db.t2.micro"
  name                 = "ExampleDB"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.demo_dbsubnet.id
  vpc_security_group_ids = [aws_security_group.interviewsg.id]
  final_snapshot_identifier = "someid"
  skip_final_snapshot  = true
}