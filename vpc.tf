resource "aws_vpc" "lou" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "lou"
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
