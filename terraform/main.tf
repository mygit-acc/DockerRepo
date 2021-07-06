provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "/home/ec2-user/.aws/credentials"
}
terraform {
  backend s3 {
    bucket         = "kiranstatefilebucket"
    dynamodb_table = "terraform-lock-file"
    encrypt        = true
    key = "terraform"
    region = "ap-south-1"
    profile = "default"
    shared_credentials_file = "/home/ec2-user/.aws/credentials"
 }
}


module "vpc" {
    source = "./VPC"
}

module "iam" {
   source = "./iam"
}

module "ekscluster" {
  source = "./ekscluster"
  eksiamrolearn = module.iam.eksiamrolearn
  eksnodegrouprolearn = module.iam.eksnodegrouprolearn
  private_subnet1 = module.vpc.private_subnet_id1
  private_subnet2 = module.vpc.private_subnet_id2

}
