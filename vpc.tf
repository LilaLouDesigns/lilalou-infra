resource "aws_vpc" "lou" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.basename
  }
}

resource "aws_subnet" "subnet-public" {
  for_each = var.subnet-public

  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]
  vpc_id            = aws_vpc.lou.id

  tags = {
    Name = "${var.basename}-public-${each.key}"
  }
}

resource "aws_subnet" "subnet-web-private" {
  for_each = var.subnet-web-private

  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]
  vpc_id            = aws_vpc.lou.id

  tags = {
    Name = "${var.basename}-web-private-${each.key}"
  }
}

resource "aws_subnet" "subnet-db-private" {
  for_each = var.subnet-db-private

  availability_zone = each.value["az"]
  cidr_block        = each.value["cidr"]
  vpc_id            = aws_vpc.lou.id

  tags = {
    Name = "${var.basename}-db-private-${each.key}"
  }
}

resource "aws_internet_gateway" "lou-igw" {
  vpc_id = aws_vpc.lou.id

  tags = {
    Name = "${var.basename}-igw"
  }
}

# Creates PUBLIC Route Tables, Routes and Associations

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.lou.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lou-igw.id
  }

  tags = {
    Name = "${var.basename}-public"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.subnet-public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}

# Creates PRIVATE Route Tables, Routes and Associations

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.lou.id

  tags = {
    Name = "${var.basename}-private"
  }
}

resource "aws_route_table_association" "web-private" {
  for_each = aws_subnet.subnet-web-private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "db-private" {
  for_each = aws_subnet.subnet-db-private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt.id
}
