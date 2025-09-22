terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

# Create VPC, Public Subnet, Private Subnets(2) and Internet Gateway
resource "aws_vpc" "My_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {Name ="My_VPC"}
}

resource "aws_subnet" "pub_sub" {
  vpc_id = aws_vpc.My_VPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {Name ="pub_sub"}
}

resource "aws_subnet" "pri_sub1" {
  vpc_id = aws_vpc.My_VPC.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {Name ="pri_sub1"} 
}

resource "aws_subnet" "pri_sub2" {
  vpc_id = aws_vpc.My_VPC.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1b"
  tags = {Name ="pri_sub2"}  
}

resource "aws_internet_gateway" "My_IG" {
  vpc_id = aws_vpc.My_VPC.id
  tags = {Name ="My_IG"}
}

resource "aws_route_table" "My_Route" {
  vpc_id = aws_vpc.My_VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.My_IG.id
  }
}

resource "aws_route_table_association" "pub_assoc" {
  subnet_id = aws_subnet.pub_sub.id
  route_table_id = aws_route_table.My_Route.id
}

#Create a Security Group for SSH
resource "aws_security_group" "SG_SSH" {
  vpc_id = aws_vpc.My_VPC.id
  description = "SSH from allowed CIDR"
  tags = {"Name" = "SG_SSH"}

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.allow_ssh_cidr]
  }
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
} 

# Create EC2 Instance 
resource "aws_instance" "MyEC2" {
    ami = var.ami_id
    instance_type = var.instance_type
    region = var.aws_region
    key_name = var.ec2_key
    subnet_id = aws_subnet.pub_sub.id
    associate_public_ip_address = true
    vpc_security_group_ids = [aws_security_group.SG_SSH.id]

    tags = {"Name" = "My Instance"}

    user_data = <<-EOF
                #! /bin/bash
                sudo su -
                yum install httpd -y
                echo " I successfully deployed the AWS infrastructure using Terraform! 🎉🎉🎉" /var/www/html/index.html
                systemctl start httpd 
                EOF
}