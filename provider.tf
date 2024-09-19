

provider "aws" {
  region = var.aws_region
}

# Rancher2 bootstrapping provider
provider "rancher2" {
  api_url   = "https://demo.mak3r.design/"
  token_key = "token-7xcz5:7kvcbv5cwql2q7w7qd94vdsjbcpwfgbpbmvsk7wtgqg4b4tjvwsfbb"
  insecure  = true
}

provider "azurerm" {
  skip_provider_registration = true # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
}