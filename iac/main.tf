terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.60.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

resource "aws_lightsail_instance" "fishbits_wordpress" {
  name              = "fishbits_wordpress"
  availability_zone = "us-west-2b"
  ip_address_type   = "ipv4"
  blueprint_id      = "wordpress"
  bundle_id         = "micro_2_0"
}
