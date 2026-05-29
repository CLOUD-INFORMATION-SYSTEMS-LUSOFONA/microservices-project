resource "aws_db_subnet_group" "main" {
  name = "week7-db-subnet-group"

  subnet_ids = [
    aws_subnet.private_1a.id,
    aws_subnet.private_1b.id
  ]
}

resource "aws_db_instance" "main" {
  identifier = "week7-database"

  engine         = "postgres"
  engine_version = "17"

  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "week7db"
  username = "dr1gues"
  password = var.db_password

  vpc_security_group_ids = [
    aws_security_group.rds.id
  ]

  db_subnet_group_name = aws_db_subnet_group.main.name

  publicly_accessible = false
  skip_final_snapshot = true
}