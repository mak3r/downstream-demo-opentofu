data "aws_ami" "suse" {
  most_recent = true
  owners      = ["679593333241"] # aws-marketplace

  filter {
    name   = "name"
    values = ["openSUSE-Leap-15.6-HVM-x86_64-prod-xkhy6u6pewna4"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "ubuntu" {
	most_recent =  true
	owners = ["898082745236"] # amazon

	filter {
	  name = "image-id"
	  values = ["ami-0b7e0d9b36f4e8f14"]
	}

	filter {
	  name = "virtualization-type"
	  values = ["hvm"]
	}
}

data "aws_ami" "gpu-ubuntu" {
	most_recent =  true
	owners = ["099720109477"] # amazon

	filter {
	  name = "image-id"
	  values = ["ami-07d9b9ddc6cd8dd30"]
	}

	filter {
	  name = "virtualization-type"
	  values = ["hvm"]
	}
}
