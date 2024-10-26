provider "aws" {
region = "ap-south-1"
}

resource "aws_instance" "e1" {
ami = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
}


