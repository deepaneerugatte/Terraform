provider "aws" {
region = "ap-south-1"
}

resource "aws_vpc" "v1" {
cidr_block = "10.0.0.0/16"
tags = {
Name = "myvpc"
}
}

resource "aws_subnet" "s1" {
cidr_block = "10.0.0.0/24"
vpc_id = aws_vpc.v1.id
availability_zone = "ap-south-1a"
map_public_ip_on_launch = true
tags = {
Name = "Public_subnet"
}
}

resource "aws_subnet" "s2" {
cidr_block = "10.0.1.0/24"
vpc_id = aws_vpc.v1.id
availability_zone = "ap-south-1a"
map_public_ip_on_launch = true
tags = {
Name = "Private_subnet"
}
}

resource "aws_internet_gateway" "ig" {
vpc_id = aws_vpc.v1.id
tags = {
Name = "int gt way"
}
}

resource "aws_route_table" "r1" {
vpc_id = aws_vpc.v1.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.ig.id
}
tags = {
Name = "Pubic_Routetable"
}
}

resource "aws_route_table_association" "ra_pub" {
subnet_id = aws_subnet.s1.id
route_table_id = aws_route_table.r1.id
}

 resource "aws_route_table" "r2" {
vpc_id = aws_vpc.v1.id
tags = {
Name = "Private_Routetable"
}
}

resource "aws_route_table_association" "ra_pvt" {
subnet_id = aws_subnet.s2.id
route_table_id = aws_route_table.r2.id
} 

resource "aws_security_group" "sg1" {
vpc_id = aws_vpc.v1.id
ingress{
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
ingress {
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
egress {
from_port = 0
to_port = 0
protocol = -1
cidr_blocks = ["0.0.0.0/0"]
}
tags = {
Name = "SG1"
}
}

resource "aws_instance" "ec1" {
ami = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
subnet_id = aws_subnet.s1.id
vpc_security_group_ids = [aws_security_group.sg1.id]
key_name = "vpc_key"
tags = {
Name = "Pub_ec1"
}
}

resource "aws_instance" "ec2" {
ami = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
subnet_id = aws_subnet.s2.id
vpc_security_group_ids = [aws_security_group.sg1.id]
key_name = "vpc_key"
tags = {
Name = "pvt_ec2"
}
}

