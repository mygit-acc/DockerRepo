resource "aws_vpc" "kiran_vpc" {
  cidr_block       = "10.1.2.0/24"
  instance_tenancy = "default"

  tags = {
    Name = "kiran_vpc"
  }
}


resource "aws_subnet" "kiran_subnet_1" {
  vpc_id     = aws_vpc.kiran_vpc.id
  cidr_block = "10.1.2.0/26"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-1"
    "kubernetes.io/cluster/mycluster" = "shared"
  }
}

resource "aws_subnet" "kiran_subnet_2" {
  vpc_id     = aws_vpc.kiran_vpc.id
  cidr_block = "10.1.2.64/26"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "private-2"
    "kubernetes.io/cluster/mycluster" = "shared"
  }
}

resource "aws_subnet" "kiran_subnet_3" {
  vpc_id     = aws_vpc.kiran_vpc.id
  cidr_block = "10.1.2.128/26"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-1"
  }
}


resource "aws_subnet" "kiran_subnet_4" {
  vpc_id     = aws_vpc.kiran_vpc.id
  cidr_block = "10.1.2.192/26"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.kiran_vpc.id

  tags = {
    Name = "kiran_igw"
  }
}

resource "aws_route_table" "kiran-public" {
  vpc_id = aws_vpc.kiran_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "kiran-public"
  }
}

resource "aws_eip" "lb" {
  vpc      = true
}

resource "aws_nat_gateway" "MYNAT" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.kiran_subnet_3.id

  tags = {
    Name = "MYNAT"
  }

  depends_on = [aws_internet_gateway.gw]
}

resource "aws_route_table" "kiran-private" {
  vpc_id = aws_vpc.kiran_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.MYNAT.id
  }

  tags = {
    Name = "kiran-private"
  }
}

resource "aws_route_table_association" "subnet-association1" {
  subnet_id      = aws_subnet.kiran_subnet_1.id
  route_table_id = aws_route_table.kiran-private.id
}

resource "aws_route_table_association" "subnet-association2" {
  subnet_id      = aws_subnet.kiran_subnet_2.id
  route_table_id = aws_route_table.kiran-private.id
}

resource "aws_route_table_association" "subnet-association3" {
  subnet_id      = aws_subnet.kiran_subnet_3.id
  route_table_id = aws_route_table.kiran-public.id
}

resource "aws_route_table_association" "subnet-association4" {
  subnet_id      = aws_subnet.kiran_subnet_4.id
  route_table_id = aws_route_table.kiran-public.id
}