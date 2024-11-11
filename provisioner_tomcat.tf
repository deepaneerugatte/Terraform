provider "aws" {
region = "ap-south-1"
}

resource "aws_key_pair" "pub_key" {
public_key = file("~/.ssh/id_rsa.pub")
key_name = "pub_key_login"
}

resource "aws_security_group" "sg2" {
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
ingress{
from_port = 8080
to_port = 8080
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

resource "aws_instance" "n1" {
ami = "ami-04a37924ffe27da53"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.sg2.id]
key_name = aws_key_pair.pub_key.key_name
tags = {
Name = "Public_instance"
}

provisioner remote-exec {
inline = [
 # Install Java
    "sudo yum install java -y",
    "sudo wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.1.31/bin/apache-tomcat-10.1.31.tar.gz",
    "sudo tar xvzf apache-tomcat-10.1.31.tar.gz",
    "sudo rm -rf apache-tomcat-10.1.31.tar.gz",
    "sudo mv apache-tomcat-10.1.31 ~/tomcat",
    "sudo chmod 777 -R ~/tomcat",
    "sudo sh ~/tomcat/bin/startup.sh"
  ]
}
provisioner file {
 source = "/opt/webapplication.war"
destination = "/home/ec2-user/tomcat/webapps/webapplication.war"
}
connection {
type = "ssh"
private_key = file("~/.ssh/id_rsa")
user = "ec2-user"
host = self.public_ip
}
}

