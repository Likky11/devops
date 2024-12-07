data "aws_vpc" "test" {
  filter {
    name = "tag:Name"
    values = ["default"]
  }
}



resource "aws_security_group" "test-sg" {
  name        = "test-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.test.id
# ... other configuration ...

  ingress {
    from_port        = 22
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description = "allow ssh to all traffic"
  }
 egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }
}
output "sg_id" {
  value = aws_security_group.test-sg.id
}
