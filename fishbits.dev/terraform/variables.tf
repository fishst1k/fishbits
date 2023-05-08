variable "environment" {
  type        = string
  description = "Unique name for your AWS environment (ie. dev)"
}

variable "lightsail_instance_name" {
  type        = string
  description = "Name of the lightsail instance"
}

variable "lightsail_availability_zone" {
  type        = string
  description = "Must be one of [ap-northeast-1{a,c,d}, ap-northeast-2{a,c}, ap-south-1{a,b}, ap-southeast-1{a,b,c}, ap-southeast-2{a,b,c}, ca-central-1{a,b}, eu-central-1{a,b,c}, eu-west-1{a,b,c}, eu-west-2{a,b,c}, eu-west-3{a,b,c}, us-east-1{a,b,c,d,e,f}, us-east-2{a,b,c}, us-west-2{a,b,c}]"
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
}

variable "lightsail_static_ip_name" {
  type        = string
  description = "Unique name for the lightsail static ip resource"
}

variable "buckets" {
  type = list(object({
    name = string
    user_role_arn = string
    tags = map(string)
  }))
  description = "List of S3 buckets."
  default = []
}