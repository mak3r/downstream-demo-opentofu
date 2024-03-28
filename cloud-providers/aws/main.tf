# Create amazonec2 cloud credential
resource "rancher2_cloud_credential" "aws_cred" {
  name = "aws_cred"
  amazonec2_credential_config {
    access_key = var.aws_access_key_id
    secret_key = var.aws_secret_access_key
  }
}

resource "aws_security_group" "sg_demo_allowall" {
  name        = "${var.prefix}-tf-demo-allowall"

  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
	ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

