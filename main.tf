terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.59.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
  default_tags {
    tags = {
      Environment = var.environment
    }
  }
}

data "aws_ami" "amazon_linux_2_ami" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ami.amazon_linux_2_ami.id
  instance_type = "t2.micro"

  tags = {
    Name = "tc2021-simple"
  }
}
