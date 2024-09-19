module "aws" {
    source = "./cloud-providers/aws"
    aws_access_key_id = var.aws_access_key_id
    aws_secret_access_key = var.aws_secret_access_key
}

module "azure" {
    source = "./cloud-providers/azure"
    azure_client_id = var.azure_client_id
    azure_client_secret = var.azure_client_secret
    azure_subscription_id = var.azure_subscription_id
    azure_tenant_id = var.azure_tenant_id
}