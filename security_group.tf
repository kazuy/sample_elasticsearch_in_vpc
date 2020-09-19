resource "aws_security_group" "elasticsearch" {
  name   = "elasticsearch"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Elasticsearch"
  }
}

resource "aws_security_group" "rdp" {
  name   = "rdp"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "RDP"
  }
}

resource "aws_security_group_rule" "rdp_to_es" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.elasticsearch.id
  source_security_group_id = aws_security_group.rdp.id
}

# see: https://dev.classmethod.jp/articles/reference-my-pubic-ip-in-terraform/
data http ifconfig {
  url = "https://ifconfig.co/ip"
}

locals {
  current-ip   = chomp(data.http.ifconfig.body)
  allowed-cidr = "${local.current-ip}/32"
}

resource "aws_security_group_rule" "connect_to_rdp" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.rdp.id
  cidr_blocks       = [local.allowed-cidr]
}
