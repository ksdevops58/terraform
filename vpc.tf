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
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "ibm-web-subnet"
  }
}


# create subnet for Database servers
resource "aws_subnet" "ibm_DB_sn" {
  vpc_id     = aws_vpc.ibm_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = "false"

  tags = {
    Name = "ibm-DB-subnet"
  }
}

# create subnet for Application servers temporary
resource "aws_subnet" "ibm_app_sn" {
  vpc_id     = aws_vpc.ibm_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "ibm-app-subnet"
  }
}


# create Internet gate way
resource "aws_internet_gateway" "ibm_igw" {
  vpc_id = aws_vpc.ibm_vpc.id

  tags = {
    Name = "ibm-internet-gateway"
  }
}

# create Public Route Table
 resource "aws_route_table" "ibm_pub_rt" {
  vpc_id = aws_vpc.ibm_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ibm_igw.id
  }

 tags = {
    Name = "ibm-public-route"
  }
}

# create Private Route Table
 resource "aws_route_table" "ibm_pvt_rt" {
  vpc_id = aws_vpc.ibm_vpc.id

  tags = {
    Name = "ibm-private-route"
  }
}

#Map public subnet with public Route table
resource "aws_route_table_association" "ibm_web_rt" {
  subnet_id      = aws_subnet.ibm_web_sn.id
  route_table_id = aws_route_table.ibm_pub_rt.id
}

resource "aws_route_table_association" "ibm_app_rt" {
  subnet_id      = aws_subnet.ibm_app_sn.id
  route_table_id = aws_route_table.ibm_pub_rt.id
}

#Map private subnet with private Route table
resource "aws_route_table_association" "ibm_DB_rt" {
  subnet_id      = aws_subnet.ibm_DB_sn.id
  route_table_id = aws_route_table.ibm_pvt_rt.id
}

#create NACL's
resource "aws_network_acl" "ibm_web_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
     cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535

  }

  tags = {
    Name = "ibm-web-nacl"
  }
}

# Web NACl association with Web subnet
resource "aws_network_acl_association" "ibm_web_nacl_association" {
  network_acl_id = aws_network_acl.ibm_web_nacl.id
  subnet_id      = aws_subnet.ibm_web_sn.id
}

#create NACL's
resource "aws_network_acl" "ibm_app_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535#create NACL's
resource "aws_network_acl" "ibm_app_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
 }

 ingress {
   protocol   = "tcp"
   rule_no    = 100
   action     = "allow"
   cidr_block = "0.0.0.0/0"
   from_port  = 0
   to_port    = 65535

  }

  tags = {
    Name = "ibm-app-nacl"
  }
}

# Web NACl association with Web subnet
resource "aws_network_acl_association" "ibm_app_nacl_association" {
  network_acl_id = aws_network_acl.ibm_app_nacl.id
  subnet_id      = aws_subnet.ibm_app_sn.id
}

  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
     cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535

  }

  tags = {
    Name = "ibm-app-nacl"
  }
}

# Web NACl association with Web subnet
resource "aws_network_acl_association" "ibm_app_nacl_association" {
  network_acl_id = aws_network_acl.ibm_app_nacl.id
  subnet_id      = aws_subnet.ibm_app_sn.id
}



#create NACL's
resource "aws_network_acl" "ibm_DB_nacl" {
  vpc_id = aws_vpc.ibm_vpc.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
     cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 65535

  }

  tags = {
    Name = "ibm-DB-nacl"
  }
}

# Web NACl association with  subnet
resource "aws_network_acl_association" "ibm_DB_nacl_association" {
  network_acl_id = aws_network_acl.ibm_DB_nacl.id
  subnet_id      = aws_subnet.ibm_DB_sn.id
}

