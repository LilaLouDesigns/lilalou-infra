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
    Name = "${var.basename}-subnet-${each.key}"
  }
}
