provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "e1" {
ami = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
tags = {
  Name = "instance1"
 }
}

resource "aws_vpc" "mumbai_vpc" {
cidr_block = "10.0.0.0/16"
 tags = {
  Name = "VPC1"
 }
}

resource "aws_subnet" "mumbai_subnet" {
vpc_id = aws_vpc.mumbai_vpc.id
cidr_block = "10.0.0.0/24"
availability_zone = "ap-south-1a"
 tags = {
   Name = "Subnet1"
 }
}

