resource "aws_route_table" "PublicRT" {
  vpc_id = aws_vpc.terraform_vpc.id

   tags = {
    "Name" = "PublicRT"
  }
}
  
  
resource "aws_route" "Internet_gateway"{

    destination_cidr_block  = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
    route_table_id = aws_route_table.PublicRT.id
  }





resource "aws_route_table_association" "Pubrta" {
  count = length(var.pub-subnet-cidr)
  subnet_id   = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.PublicRT.id
}

 resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.terraform_vpc.id
  
  
  tags = {
    "Name" = "PrivateRT"
  }


}  
  
resource "aws_route" "Nat_gateway" {
  count = length(var.pri-subnet-cidr)
  route_table_id = element(aws_route_table.PrivateRT.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = element(aws_nat_gateway.main.*.id,0)

  

 }

resource "aws_route_table_association" "Prirta" {

  count = length(var.pri-subnet-cidr)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.PrivateRT.*.id, count.index)
}