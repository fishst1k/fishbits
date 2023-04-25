resource "aws_route53_zone" "fishbits_dev" {
  name = "fishbits.dev"
}

resource "aws_route53_record" "fishbits_alias" {
  zone_id = aws_route53_zone.fishbits_dev.zone_id
  name    = "fishbits.dev"
  type    = "A"
  ttl     = 300
  records = [aws_lightsail_static_ip.fishbits_static_ip.ip_address]
}

resource "aws_route53_record" "fishbits_www_cname" {
  zone_id = aws_route53_zone.fishbits_dev.zone_id
  name    = "www.fishbits.dev"
  type    = "CNAME"
  ttl     = 300
  records = [aws_route53_record.fishbits_alias.name]
}
