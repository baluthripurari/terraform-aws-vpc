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
resource "aws_subnet" "public" { # first name is public[0], second name is public[1]
    count = length(var.public_subnet_cidrs)
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = true
    vpc_id     = aws_vpc.main.id
    cidr_block = var.public_subnet_cidrs[count.index]

 tags = merge(
        var.common_tags,
        var.public_subnet_cidrs_tags,

        {
            Name = "${local.resource_name}-public-${local.az_names[count.index]}"
        }
    )
}
    
  ## private Subnet ###
resource "aws_subnet" "private" { # first name is private[0], second name is private[1]
    count = length(var.private_subnet_cidrs)
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = false
    vpc_id     = aws_vpc.main.id
    cidr_block = var.private_subnet_cidrs[count.index]

 tags = merge(
        var.common_tags,
        var.private_subnet_cidrs_tags,

        {
            Name = "${local.resource_name}-private-${local.az_names[count.index]}"
        }
    )
}


  ## Database Subnet ###
resource "aws_subnet" "Database" {       # first name is database[0], second name is database[1]
    count = length(var.Database_subnet_cidrs)
    availability_zone = local.az_names[count.index]
    map_public_ip_on_launch = false
    vpc_id     = aws_vpc.main.id
    cidr_block = var.Database_subnet_cidrs[count.index]

 tags = merge(
        var.common_tags,
        var.Database_subnet_cidrs_tags,

        {
            Name = "${local.resource_name}-Database-${local.az_names[count.index]}"
        }
    )
}

resource "aws_db_subnet_group" "default" {
  name       = "${local.resource_name}"
  subnet_ids = aws_subnet.Database[*].id

  tags = merge(
        var.common_tags,
        var.Databse_subnet_group_tags,

        {
            Name = "${local.resource_name}"
        }
    )
}
resource "aws_eip" "NAT" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "NAT" {
  allocation_id = aws_eip.NAT.id
  subnet_id     = aws_subnet.public[0].id

 tags = merge(
        var.common_tags,
        var.aws_nat_gateway_tags,

        {
            Name = "${local.resource_name}" #expense-dev
        }
    )


     # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.igw]   # explicit dependency
} 



### Public_Route_tables #####

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
        var.common_tags,
        var.public_route_table_tags,

        {
            Name = "${local.resource_name}-public"
        }
    )
}



### Private_Route_tables #####
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
        var.common_tags,
        var.private_route_table_tags,

        {
            Name = "${local.resource_name}-private"
        }
    )
}


### Database_Route_tables #####
resource "aws_route_table" "Database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
        var.common_tags,
        var.Database_route_table_tags,

        {
            Name = "${local.resource_name}-Database"
        }
    )
}

# ROUTES#
resource "aws_route" "public_route" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}


resource "aws_route" "private_route_NAT" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT.id
}


resource "aws_route" "Database_route_NAT" {
  route_table_id            = aws_route_table.Database.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.NAT.id
}



#### ROUTE TABLE ASSOSIATION TO SUBNET ##
resource "aws_route_table_association" "public" {
    count = length(var.public_subnet_cidrs)
    subnet_id      = element(aws_subnet.public[*].id, count.index)
    route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
    count = length(var.private_subnet_cidrs)
    subnet_id      = element(aws_subnet.private[*].id, count.index)
    route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "Database" {
    count = length(var.Database_subnet_cidrs)
    subnet_id      = element(aws_subnet.Database[*].id, count.index)
    route_table_id = aws_route_table.Database.id
}
