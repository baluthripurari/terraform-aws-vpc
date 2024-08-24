resource "aws_vpc" "main" { # creating a vpc
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    var.common_tags,
    var.vpc_tags,

   {
        Name = local.resource_name
   }

  )
}  

#attaching internet gateway to vpc [0.0.0.0.0]



resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
        var.common_tags,
        var.igw_tags,

        {
            Name = local.resource_name
        }
    )
  }

## public Subnet ###
resource "aws_subnet" "public" {
    count = length(var.public_subnet_cidrs)
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidrs[count.index]

 tags = merge(
        var.common_tags,
        var.public_subnet_cidrs,

        {
            Name = local.resource_name
        }
    )
}
    
  