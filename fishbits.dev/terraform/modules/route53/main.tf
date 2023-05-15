terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

resource "aws_route53_zone" "route53" {
  name = var.zone_name
}

resource "aws_route53_record" "route53" {
  for_each = {for each in var.records: each.name => each}

  zone_id = aws_route53_zone.route53.zone_id
  name = each.value.name
  type = each.value.type
  ttl = each.value.ttl
  records = each.value.records
}
