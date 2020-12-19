resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.terraform_vpc.id

}

resource "aws_eip" "nat" {
 vpc      = true
}


resource "aws_nat_gateway" "main" {
    count = length(var.pub-subnet-cidr)
    subnet_id = element(aws_subnet.public.*.id, count.index)
    allocation_id = element(aws_eip.nat.*.id,count.index)

    depends_on = [aws_internet_gateway.gw]
}

