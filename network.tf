resource "aws_vpc" "main" {
  cidr_block = "12.0.0.0/16"

  tags = {
    Name = "Elasticsearch and RDP sample VPC"
  }
}

resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "12.0.1.0/24"

  tags = {
    Name = "Elasticsearch and RDP sample Subnet"
  }
}
