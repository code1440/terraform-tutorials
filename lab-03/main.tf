
resource "aws_s3_bucket" "bcrbucket-1" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = "bcrbucket-1"
  acl    = "private"
}

provider "aws" {
  region = "us-east-1"

}

# Change the aws_instance we declared earlier to now include "depends_on"
resource "aws_instance" "ec2-tf" {
  ami           = "ami-6871a115"
  instance_type = "t2.micro"

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = ["aws_s3_bucket.bcrbucket-1"]
}