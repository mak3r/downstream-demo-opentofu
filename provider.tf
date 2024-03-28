

provider "aws" {
  region = var.aws_region
}

# Rancher2 bootstrapping provider
provider "rancher2" {
  api_url   = "https://demo.mak3r.design"
  token_key = "token-ckpg4:wht9z5nms8vmszfp27rqk8x9hrqt9tg6svdv7qtqzjv4klkvr5g8v2"
  insecure  = false
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}