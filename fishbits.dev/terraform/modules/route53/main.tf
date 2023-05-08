resource "aws_route53_zone" "route53_zone" {
  name = var.zone_name
}

resource "aws_route53_record" "route53_zone" {
  for_each = {for each in var.records: each.name => each}

  zone_id = aws_route53_zone.route53_zone.zone_id
  name = each.value.name
  type = each.value.type
  ttl = each.value.ttl
  records = each.value.records
}
