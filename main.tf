module "instance" {
source = "./ec2"
sg_id = [module.sg.sg_id]
}

module "sg" {
source = "./sg"
}
module "s3" {
  source = "./s3"
}
module "aws_launch_template" {
source = "./asg" 
}
