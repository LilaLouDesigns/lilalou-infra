resource "aws_vpc" "lou" {
    cidr_block = "10.0.0.0/16"

    tags = {
        Name = "lou"
    }
}
