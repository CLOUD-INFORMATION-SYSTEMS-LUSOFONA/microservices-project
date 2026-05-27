aws_region           = "eu-central-1"
instance_type        = "t3.micro"
key_name             = "miguelrodr1"
vpc_cidr             = "10.0.0.0/16"
azs                  = ["eu-central-1a", "eu-central-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.20.0/24"]
allowed_ports        = [22, 80, 443]
allowed_cidr_blocks  = ["0.0.0.0/0"]
db_name              = "week8db"
db_username          = "dr1gues"
db_instance_class    = "db.t3.micro"
db_engine            = "postgres"
db_engine_version    = "17"
db_port              = 5432

