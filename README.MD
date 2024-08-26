#  VPC and Perring B/W two VPC

![Description](vpc&peering1.drawio.svg)


This module creates resources in First 2 Availability Zones for High Availability on 'US-EAST-1'

* VPC
* Internet Gatway
* Internet Gateway and VPC attachment
* 2 Public Subnets
* 2 Private Subnets
* 2 Database subnets
* Databse subnets grouping
* Elastic IP
* NAT Gatway
* Public Route table
* Private Route table
* Database Route table
* Route Table associations
* Routes in all tables
* peering if requried for user
* Route of peering in requestor and acceptor VPC

# Inputs

* Project_name (Requried): User should mention their project name.type is string.
* Environmet (Optional) : Default value is dev . type is string.
* Comman tags (requried) : User should provide their tags to their project . type is map.
* vpc_cidr (option) : default value is 10.0.0.0/16 . type is string.
* enable_DNS_Hostname (Optional) :Default value is true . type is bool.
* vpc_tags (optional) : Default is empty . type is map.
* iGW_tags (optional) : Default is empty . type is map.
* public_subnet_cidrs (Required) : user has to provide 2 valid subnet CIDR.
* private_subnet_cidrs (Required) : user has to provide 2 valid subnet CIDR.
* Database_subnet_cidrs (Required) : user has to provide 2 valid subnet CIDR.
* public_subnet_cidrs_tags (optional) : Default is empty . type is map.
* private_subnet_cidrs_tags (optional) : Default is empty . type is map.
* Database_subnet_cidrs_tags (optional) : Default is empty . type is map.
* Database_subnet_group_tags (optional) : Default is empty . type is map.
* aws_nat_gateway_tags (optional) : Default is empty . type is map.
* public_route_table_tags (optional) : Default is empty . type is map.
* private_route_table_tags (optional) : Default is empty . type is map.
* Database_route_table_tags (optional) : Default is empty . type is map.
* is_peering_required (optional) : Default value is false . type is bool.
* acceptor_vpc_id (optional) : Default is empty . type is map. Default VPC ID would be taken. type is string
* vpc_peering_tags (optional) : Default is empty . type is map.


