resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
  description = "Allow ssh inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "Bastion Security Group"
    }
}

resource "aws_security_group" "application_sg" {
  name        = "application_sg"
  description = "Allow ssh and port 3000 inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr] 
  }
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
    tags = {
        Name = "Application Security Group"
    }
}

resource "aws_security_group" "mysql_sg" {
  name = "mysql_sg"
  description = "Allow mysql inbound traffic on 3306 and all outbound traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "MySQL Security Group"
  }
  
}
resource "aws_security_group" "redis_sg" {
  name = "redis_sg"
  description = "Allow mysql inbound traffic on 6379 and all outbound traffic"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
  tags = {
    Name = "Redis Security Group"
  }
}