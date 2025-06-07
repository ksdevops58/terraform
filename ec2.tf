#Ec2 instance
resource "aws_instance" "ibm_web_server" {
  ami           = ami-03f8acd418785369b
  instance_type = "t3.micro"
  key-name = "terraform-oregon"
  subnet_id= "aws_subnet.ibm_web_sn.id"
  vpc_security_group_ids = ["aws_security_group.ibm_web_sg.id"]
  user_data = file("app.sh")
  tags = {
    Name = "HelloWorld"
  }
}
