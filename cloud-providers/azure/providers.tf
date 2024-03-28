
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    rancher2 = {
      source = "hashicorp/rancher2"
      version = "~> 4.0"
    }
  }
}