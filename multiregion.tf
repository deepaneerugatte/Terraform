provider "aws" {
  alias = "Mumbai"
  region = "ap-south-1"
}

provider "aws"{
alias = "Virginia"
region = "us-east-1"
}

resource "aws_instance" "instance1" {
  ami             = "ami-04a37924ffe27da53"
  instance_type   = "t2.micro"
  provider = "aws.Mumbai"
}
resource "aws_instance" "instance2" {
  ami = "ami-06b21ccaeff8cd686"
  instance_type   = "t2.micro"
  provider = "aws.Virginia"
}

resource "aws_instance" "instance3" {
  ami             = "ami-04a37924ffe27da53"
  instance_type   = "t2.micro"
  provider = "aws.Mumbai"
}

