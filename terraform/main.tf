provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = var.credentialfile
}
terraform {
  backend "s3" {
    bucket         = "kiranstatefilebucket"
    encrypt        = true
    key = "terraform"
    region = "ap-south-1"
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
