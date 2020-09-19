resource "aws_vpc" "main" {
  cidr_block = "12.0.0.0/16"

  tags = {
    Name = "Elasticsearch and RDP sample VPC"
  }
}
