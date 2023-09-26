
provider "aws" {
  region = "ap-south-1" 
}

resource "aws_vpc" "anish_vpc" {
  cidr_block = "20.0.0.0/16"
}

resource "aws_subnet" "publicsub" {
  vpc_id                  = aws_vpc.anish_vpc.id
  cidr_block              = "20.0.1.0/24" 
  availability_zone       = "ap-south-1a"  
  map_public_ip_on_launch = true
}

# Create a private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.anish_vpc.id
  cidr_block              = "20.0.2.0/24"
  availability_zone       = "ap-south-1a" 
}


resource "aws_instance" "anish_ec2" {
  ami           = "ami-067c21fb1979f0b27"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.publicsub.id

  root_block_device {
    volume_size = 8
    volume_type = "gp2"
  }

  tags = {
    Name    = "AnishInstance"
    purpose = "Assignment"
  }
}


resource "aws_security_group" "security_group_anish-anish" {
  name        = "security-group"
  description = "Assignment Security Group"
  vpc_id      = aws_vpc.anish_vpc.id


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
}
