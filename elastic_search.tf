resource "aws_iam_service_linked_role" "main" {
  aws_service_name = "es.amazonaws.com"
}

resource "aws_elasticsearch_domain" "main" {
  domain_name           = "sample-elasticsearch"
  elasticsearch_version = "7.7"

  cluster_config {
    instance_type = "t2.small.elasticsearch"
  }

  vpc_options {
    subnet_ids         = [aws_subnet.main.id]
    security_group_ids = [aws_security_group.elasticsearch.id]
  }

  ebs_options {
    ebs_enabled = true
    volume_type = "gp2"
    volume_size = 10
  }

  snapshot_options {
    automated_snapshot_start_hour = 18
  }

  tags = {
    Name = "Elasticsearch and RDP sample"
  }

  depends_on = [aws_iam_service_linked_role.main]
}

resource "aws_elasticsearch_domain_policy" "main" {
  domain_name = aws_elasticsearch_domain.main.domain_name

  access_policies = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Action    = "es:*"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "${aws_elasticsearch_domain.main.arn}/*"
        },
      ]
    }
  )
}
