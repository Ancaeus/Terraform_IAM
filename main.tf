provider "aws" {
  version    = "~> 2.12"
  region     = var.aws_region
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}

terraform {
  backend "s3" {
    encrypt = true
    region  = "eu-west-1"
    bucket  = "terraform-666"
    key     = "aws-account-utils/terraform/terraform.tfstate"
  }
}
