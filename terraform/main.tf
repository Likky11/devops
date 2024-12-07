module "instance" {
count = 0
source = "./ec2"
sg_id = [module.sg[count.index].sg_id]
}

module "sg" {
count =0
source = "./sg"
}

module "s3" {
  source = "./s3"
}
