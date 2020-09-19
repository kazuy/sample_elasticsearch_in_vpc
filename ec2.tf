# Microsoft Windows Server 2019 Base
resource "aws_instance" "main" {
  ami                         = "ami-0afc3e2b95d00c51a"
  instance_type               = "t3.micro"
  key_name                    = "rdp-key" # already created
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.rdp.id]
  associate_public_ip_address = true

  tags = {
    Name = "Elasticsearch and RDP sample"
  }
}
