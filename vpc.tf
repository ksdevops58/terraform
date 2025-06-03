# AWS VPC creation
resource "aws_vpc" "ibm_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ibm-vpc"
  }
}


# create subnet for web servers
resource "aws_subnet" "ibm_web_sn" {
  vpc_id     = aws_vpc.ibm_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2"

  tags = {
    Name = "ibmweb-subnet"
  }
}
