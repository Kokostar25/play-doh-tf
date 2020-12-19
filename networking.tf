provider "aws" {
  region = var.region
}
resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "public" {
  count = length(var.pub-subnet-cidr) 
  vpc_id  = aws_vpc.terraform_vpc.id
  cidr_block = element(var.pub-subnet-cidr,count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = true
  
     tags = {
    Name = "public-subnet - ${count.index+1}"
  }
}


resource "aws_subnet" "private" {
  count = length(var.pri-subnet-cidr) 
  vpc_id = aws_vpc.terraform_vpc.id
  cidr_block = element(var.pri-subnet-cidr,count.index)
  availability_zone = data.aws_availability_zones.azs.names[count.index]
  map_public_ip_on_launch = false
  

  tags = {
    Name = "private-subnet - ${count.index+1}"
  }

}

 

/* output "vpc_id" {
  value = aws_vpc.terraform_vpc.id
  
  }

 resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = aws_subnet.public.*.id

  enable_deletion_protection = true

  access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}   */