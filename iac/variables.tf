variable "lightsail_instance_name" {
  type        = string
  description = "Name of the lightsail instance"

  validation {
    condition     = length(var.lightsail_instance_name) > 0
    error_message = "lightsail_instance_name requires a value"
  }
}

variable "lightsail_availability_zone" {
  type        = string
  description = "Must be one of [ap-northeast-1{a,c,d}, ap-northeast-2{a,c}, ap-south-1{a,b}, ap-southeast-1{a,b,c}, ap-southeast-2{a,b,c}, ca-central-1{a,b}, eu-central-1{a,b,c}, eu-west-1{a,b,c}, eu-west-2{a,b,c}, eu-west-3{a,b,c}, us-east-1{a,b,c,d,e,f}, us-east-2{a,b,c}, us-west-2{a,b,c}]"

  validation {
    condition = contains([
      "ap-northeast-1a",
      "ap-northeast-1c",
      "ap-northeast-1d",
      "ap-northeast-2a",
      "ap-northeast-2c",
      "ap-south-1a",
      "ap-south-1b",
      "ap-southeast-1a",
      "ap-southeast-1b",
      "ap-southeast-1c",
      "ap-southeast-2a",
      "ap-southeast-2b",
      "ap-southeast-2c",
      "ca-central-1a",
      "ca-central-1b",
      "eu-central-1a",
      "eu-central-1b",
      "eu-central-1c",
      "eu-west-1a",
      "eu-west-1b",
      "eu-west-1c",
      "eu-west-2a",
      "eu-west-2b",
      "eu-west-2c",
      "eu-west-3a",
      "eu-west-3b",
      "eu-west-3c",
      "us-east-1a",
      "us-east-1b",
      "us-east-1c",
      "us-east-1d",
      "us-east-1e",
      "us-east-1f",
      "us-east-2a",
      "us-east-2b",
      "us-east-2c",
      "us-west-2a",
      "us-west-2b",
      "us-west-2c"
    ], var.lightsail_availability_zone)

    error_message = "Must be a valid lightsail availability_zone"
  }
}

variable "lightsail_ip_address_type" {
  type        = string
  description = "The IP address type of the Lightsail Instance. Valid Values: dualstack | ipv4"

  default = "ipv4"
}

variable "lightsail_blueprint" {
  type        = string
  description = "One of the blueprints listed by the AWS cli - aws lightsail get-blueprints"

  default = "wordpress"
}

variable "lightsail_bundle_id" {
  type        = string
  description = "The bundle id of the instance"

  default = "micro_2_0"

  validation {
    condition     = can(regex("(nano|micro|small|medium|large|xlarge|2xlarge)_2_[012]", var.lightsail_bundle_id))
    error_message = "budle id must be a supported instance type"
  }
}

variable "lightsail_static_ip_name" {
  type        = string
  description = "Unique name for the lightsail static ip resource"

  validation {
    condition     = length(var.lightsail_static_ip_name) > 0
    error_message = "lightsail_static_ip_name requires a value"
  }
}
