provider "aws" {
  version = "~> 3.3.0"
  region = "ap-south-1"
  shared_credentials_file = "${var.credentialfile}"
  profile = "devops"
}

terraform {
  backend "s3" {
    bucket         = "kiranstatefilebucket"
    encrypt        = true
    key = "terraform.tfstate"
    region = "ap-south-1"
    profile = "devops"
 }
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "kiranstatefilebucket"
    encrypt        = true
    key = "terraform.tfstate"
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
