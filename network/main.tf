resource "aws_vpc" "main" {
  cidr_block = var.base_cidr

  tags = {
    Name = "${var.environment}-main-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.environment}-main-egw"
  }
}

resource "aws_subnet" "public" {
  cidr_block              = cidrsubnet(var.base_cidr, 8, 1)
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-public-subnet"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.environment}-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public.id
}

resource "aws_security_group" "default" {
  vpc_id = aws_vpc.main.id
  name = "${var.environment}-default"

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_security_group" "private_access" {
  vpc_id = aws_vpc.main.id
  name   = "${var.environment}-private-access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "Deployer SSH"
    cidr_blocks = var.ssh_source_whitelist
  }
}

resource "aws_security_group" "www" {
  vpc_id = aws_vpc.main.id
  name = "${var.environment}-www"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
}
