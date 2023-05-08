variable "user_role_arn" {
  type        = string
  description = "The user_role_arn of the account being used by terraform"
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket"
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}