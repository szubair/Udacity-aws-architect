provider "aws" {
  region = "us-east-1"
}

module "ec2_cluster_T2" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Udacity T2"
  instance_count         = 4

  ami                    = "ami-0c6b1d09930fac512"
  instance_type          = "t2.micro"
  monitoring             = true
  vpc_security_group_ids = ["sg-0f7c99a36a9020d85"]
  subnet_id              = "subnet-038b6599cc5cb58e8"

  tags = {
    Name = "Udacity T2"
  }
}

module "ec2_cluster_M4" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "Udacity M4"
  instance_count         = 2

  ami                    = "ami-0c6b1d09930fac512"
  instance_type          = "m4.large"
  monitoring             = true
  vpc_security_group_ids = ["sg-0f7c99a36a9020d85"]
  subnet_id              = "subnet-038b6599cc5cb58e8"

  tags = {
    Name = "Udacity M4"
  }
}

