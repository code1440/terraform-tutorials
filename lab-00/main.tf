provider "aws" {
  region = "us-east-1"

}

data "aws_ami" "rhel" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "web" {
  ami           = "ami-6871a115"
  instance_type = "t2.micro"
  security_groups = [
        "sep06"
    ]

  tags {
    Name = "rhel"
  }
}