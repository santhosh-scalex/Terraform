# configured aws provider with proper credentials
provider "aws" {
  region  = "us-east-2"
}


# create security group for the web server
resource "aws_security_group" "webserver_security_group" {
  name        = "webserver security group"
  description = "enable http access on port 80"
  vpc_id      = "vpc-00be855b085ce5d52" 

  ingress {
    description      = "http access"
    from_port        = 80 
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "webserver security group"
  }
}

# create security group for the database
resource "aws_security_group" "database_security_group" {
  name        = "database security group"
  description = "enable postgresql access on port 5432"
  vpc_id      = "vpc-00be855b085ce5d52"

  ingress {
    description      = "postgresql"
    from_port        = 5432
    to_port          = 5432
    protocol         = "tcp"
    security_groups  = [aws_security_group.webserver_security_group.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "database_security_group"
  }
}


# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name         = "database_subnet_group"
  subnet_ids   = ["subnet-07cee3886a71958bc","subnet-0761803c631a2a21c"]
  description  = "database subnet group"

  tags   = {
    Name = "rds-db-subnet-group"
  }
}


# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = "postgres"
  engine_version          = "13.7"
  multi_az                = false
  identifier              = "ss-dev-database"
  username                = "ssdatabase"
  password                = "ssdatabase123678"
  instance_class          = "db.t3.micro"
  allocated_storage       = 5
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.database_security_group.id]
  availability_zone       = "us-east-2a"
  db_name                 = "ssdev"
  skip_final_snapshot     = true
}
