provider "aws" {
region = "ap-south-1"
}

variable "description" {
description = "create the ec2-instance in  AWS cloud"
}

variable "ami_id" {
description = "AMI_ID for  instance"
default = "ami-04a37924ffe27da53"
}

variable "instance_type" {
description = "providing instance type"
default = "t2.micro"
}

resource "aws_instance" "e1" {
ami = var.ami_id
instance_type = var.instance_type 
}

output "public-ip" {
description = "Public IP for the instance created"
value = aws_instance.e1.public_ip
}
