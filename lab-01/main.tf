# provider "aws" {
#   region = "us-east-1"

# }

data "aws_ami" "rhel" {
  most_recent = true
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-6871a115"
  instance_type = "t2.micro"
  security_groups = [
        "sep06"
    ]
  key_name = "fullstack"
  tags {
    Name = "rhel"
  }
  provisioner "remote-exec" {
    inline = [
      "hostname -f"
    ]
    connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key  = "${file("~/Downloads/fullstack.pem")}"
  }
  }
  
   provisioner "local-exec" {
    command = "ansible-playbook -i ${aws_instance.jenkins.public_ip}, install-jenkins.yml"
  }
}