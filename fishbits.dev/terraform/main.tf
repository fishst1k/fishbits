terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-west-2"
}

terraform {
  backend "s3" {
    bucket = "fishbits-terraform-state"
    key    = "fishbits-dev/terraform.tstate"
    region = "us-west-2"
  }
}

module "lightsail" {
  source = "./modules/lightsail"

  lightsail_instance_name = var.lightsail_instance_name
  lightsail_availability_zone = var.lightsail_availability_zone
  lightsail_ip_address_type = var.lightsail_ip_address_type
  lightsail_blueprint = var.lightsail_blueprint
  lightsail_bundle_id = var.lightsail_bundle_id
  lightsail_static_ip_name = var.lightsail_static_ip_name
}

module "s3_bucket_tfstate" {
  source = "./modules/s3"

  bucket_name = var.bucket_name
  user_role_arn = var.user_role_arn

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}

module "route53" {
  source = "./modules/route53"
  zone_name = "fishbits.dev"

  records = [
    {
      name = "fishbits.dev"
      type = "A"
      ttl = 300
      records = [module.lightsail.static_ip]
    },
    {
      name = "www.fishbits.dev"
      type = "CNAME"
      ttl = 300
      records = ["fishbits.dev"]
    }
  ]
}
