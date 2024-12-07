#provider "aws"{
#region       ="us-east-1"
#access_key   ="AKIAW3MEA4PTRSSMUOD4"
#secret_key   ="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"


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
