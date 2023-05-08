output "static_ip" {
    description = "The static IP of the lightsail instance."
    value = aws_lightsail_static_ip.lightsail.ip_address
}