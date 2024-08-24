variable "project_name" {
  type = string
  
}
variable "environment" {
  type = string
  default = "dev"
}
variable "common_tags" {
  type = map
  
}

###VPC###
variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "enable_dns_hostnames" {
  type = bool
  default = true
}

variable "vpc_tags" {
  type = map
  default = {}
}


## IGW ##
variable "igw_tags" {
  type = map
  default = {}
}

## public subnet variables ##
variable "public_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.public_subnet_cidrs) == 2
    error_message = "please provide 2 valid public subnet CIDR"
  }
}