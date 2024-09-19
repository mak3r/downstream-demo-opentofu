
# Resource group containing aks module resources
resource "azurerm_resource_group" "tf_aks_rg" {
  name     = "${var.prefix}-tf-aks-rg-01"
  location = var.azure_location

  tags = {
    Creator = "${var.prefix}"
  }
}
module "aks" {
    source = "./aks"
    # From parent
    azure_client_id = var.azure_client_id
    azure_client_secret = var.azure_client_secret
    azure_subscription_id = var.azure_subscription_id
    azure_tenant_id = var.azure_tenant_id
    # From local module
    resource_group = azurerm_resource_group.tf_aks_rg.name
    cloud_credentials = rancher2_cloud_credential.azure_cred.id
}


# Resource group containing instance module resources
resource "azurerm_resource_group" "tf_instances_rg" {
  name     = "${var.prefix}-tf-instances-rg"
  location = var.azure_location

  tags = {
    Creator = "${var.prefix}"
  }
}
module "instances" {
    source = "./instances"
    # From parent
    azure_client_id = var.azure_client_id
    azure_client_secret = var.azure_client_secret
    azure_subscription_id = var.azure_subscription_id
    azure_tenant_id = var.azure_tenant_id
    # From local module
    resource_group = azurerm_resource_group.tf_instances_rg.name
    cloud_credentials = rancher2_cloud_credential.azure_cred.id
}

# Create azure cloud credential
resource "rancher2_cloud_credential" "azure_cred" {
  name = "${var.prefix}-azure_cred"
  azure_credential_config {
    subscription_id = var.azure_subscription_id
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
  }
}
