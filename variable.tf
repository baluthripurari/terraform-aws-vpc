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
variable "public_subnet_cidrs_tags" {
  type =  map
  default = {}

}


## private subnet variables ##
variable "private_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.private_subnet_cidrs) == 2
    error_message = "please provide 2 valid private subnet CIDR"
  }
}
variable "private_subnet_cidrs_tags" {
  type =  map
  default = {}

}

## Database subnet variables ##
variable "Database_subnet_cidrs" {
  type = list
  validation {
    condition = length(var.Database_subnet_cidrs) == 2
    error_message = "please provide 2 valid private subnet CIDR"
  }
}
variable "Database_subnet_cidrs_tags" {
  type =  map
  default = {}

}


  # NAT_GATEWAY_TAGS
variable "aws_nat_gateway_tags" {
  type = map
  default = {}
}



## Route_tables ##

variable "public_route_table_tags" {
  type = map
  default = {}
}


variable "private_route_table_tags" {
  type = map
  default = {}
}


variable "Database_route_table_tags" {
  type = map
  default = {}
}

