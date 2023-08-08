# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az1 
resource "aws_eip" "eip_for_nat_gateway" {
  vpc    = true 

  tags   = {
    Name = "EIP"
  }
}

# allocate elastic ip. this eip will be used for the nat-gateway in the public subnet az2
# resource "aws_eip" "eip_for_nat_gateway_az2" {
#  vpc    = "vpc-00be855b085ce5d52"

#  tags   = {
#     Name = "EIP 2"
#   }
# }

# create nat gateway in public subnet az1
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip_for_nat_gateway.id
  subnet_id     =  aws_subnet.public_subnet_az1.id  #(subnet-073ea4b1f8eb4b623) 

  tags   = {
    Name = " NAT Gateway"
  }
}

#   # to ensure proper ordering, it is recommended to add an explicit dependency
#   depends_on = 
# }

# # create nat gateway in public subnet az2
# resource "aws_nat_gateway" "nat_gateway_az2" {
#   allocation_id = 
#   subnet_id     = 

#   tags   = {
#     Name = 
#   }

#   # to ensure proper ordering, it is recommended to add an explicit dependency
#   # on the internet gateway for the vpc.
#   depends_on = 
# }

# create private route table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id            = aws_vpc.main.id                   

  route {
    cidr_block      = "0.0.0.0/0"
    nat_gateway_id  = aws_nat_gateway.nat_gateway.id
  }

  tags   = {
    Name = "private route table"
  }
}
