variable "zone_name" {
  type = string
  description = "The route53 zone name."
}

variable "records" {
  type = list(object({
    name = string
    type = string
    ttl = number
    records = list(string)
  }))
}