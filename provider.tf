

provider "aws" {
  region = var.aws_region
}

# Rancher2 bootstrapping provider
provider "rancher2" {
  api_url   = "https://${var.rancher_subdomain}.${var.domain}/"
  token_key = var.rancher_access_token
  insecure  = true
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}