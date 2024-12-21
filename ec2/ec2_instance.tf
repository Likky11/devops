provider "aws" {
  region = "us-east-1"  # Ensure this matches the region where your VPC is located
}
data "aws_ami" "ubuntu" {
  most_recent = true
    owners      = ["amazon"]
  filter {
    name   = "architecture"
    values = ["arm64"]
  }
  filter {
    name  = "name"
    values = ["al2023-ami-2023*"]
  }
}
resource "aws_instance" "test" {
  ami  = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "Test"
  }
vpc_security_group_ids = var.sg_id #[aws_security_group.test-sg.id]
key_name = "test"
user_data = <<EOF
#!/bin/bash
mkdir /home/ubuntu/sai
echo "hello sai" >> /home/ubuntu/sai/test
sudo apt update -y
sudo apt install -y apache2
sudo systemctl status apache2
sudo apt install amazon-ec2-utils
public_ip=$(ec2-metadata --public-ip | awk '{print $2}')
echo "$public_ip"
echo "<!DOCTYPE html>
<html>
<head>
    <title>Sample Page</title>
</head>
<body>
    <h1>Welcome to your dev_training server $public_ip</h1>
</body>
</html>" | sudo tee /var/www/html/index.html
EOF

}
variable "sg_id" {
type = list(string)
default = ["sg-03f755c64f713e25e"]
}