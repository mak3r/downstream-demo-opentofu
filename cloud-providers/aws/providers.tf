
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    rancher2 = {
      source = "hashicorp/rancher2"
      version = "~> 4.0"
    }
  }
}