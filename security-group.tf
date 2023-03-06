# ALB Public security group
resource "aws_security_group" "public_http_https" {
  name        = "public_http_https"
  description = "Allow 80, 443 inbound traffic"
  vpc_id      = aws_vpc.lou.id

  ingress {
    description = "HTTPS from internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "public_http_https"
  }
}

# BASTION Public security group
resource "aws_security_group" "public_ssh" {
  name        = "public_ssh"
  description = "Allow SSH port 22 inbound traffic from My IP"
  vpc_id      = aws_vpc.lou.id

  ingress {
    description = "SSH port 22 inbound from My IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["202.142.36.143/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "public_ssh"
  }
}

# Web Private security group
resource "aws_security_group" "private_http_https" {
  name        = "private_http_https"
  description = "Allow 80, 443 inbound traffic from ALB-SG"
  vpc_id      = aws_vpc.lou.id

  ingress {
    description     = "HTTPS from ALB-SG"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http_https.id]
  }

  ingress {
    description     = "HTTP from ALB-SG"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.public_http_https.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private_http_https"
  }
}

# DB Private security group
resource "aws_security_group" "private_mysql" {
  name        = "private_mysql"
  description = "Allow port 3306 inbound traffic from private_http_https"
  vpc_id      = aws_vpc.lou.id

  ingress {
    description     = "HTTPS from private_http_https"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.private_http_https.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "private_mysql"
  }
}
