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

# Configure an alias provider for Route53
provider "aws" {
  region = "us-east-1"
  alias  = "useast1"
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
  for_each = {for each in var.buckets: each.name => each}

  bucket_name = each.value.name
  user_role_arn = each.value.user_role_arn

  tags = each.value.tags
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
