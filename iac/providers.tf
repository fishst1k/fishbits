terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

# Configure an alias provider for Route53
provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
}