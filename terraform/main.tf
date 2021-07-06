provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "C:/Users/chilakala.sai.kiran/.aws/credentials"
}

module "vpc" {
    source = "./vpc"
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