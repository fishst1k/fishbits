resource "aws_lightsail_instance" "fishbits_wordpress" {
  name              = var.lightsail_instance_name
  availability_zone = var.lightsail_availability_zone
  ip_address_type   = var.lightsail_ip_address_type
  blueprint_id      = var.lightsail_blueprint
  bundle_id         = var.lightsail_bundle_id

  add_on {
    type = "AutoSnapshot"
    snapshot_time = "06:00"
    status = "Enabled"
  }
}

resource "aws_lightsail_static_ip_attachment" "fishbits_static_ip_attachment" {
  static_ip_name = aws_lightsail_static_ip.fishbits_static_ip.id
  instance_name  = aws_lightsail_instance.fishbits_wordpress.id
}

resource "aws_lightsail_static_ip" "fishbits_static_ip" {
  name = var.lightsail_static_ip_name
}
