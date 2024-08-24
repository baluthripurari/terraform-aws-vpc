variable "vpc_cidr" {
  type = string
  default = "10.0.0.0./16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}