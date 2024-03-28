# Create amazonec2 cloud credential
resource "rancher2_cloud_credential" "azure_cred" {
  name = "azure_cred"
  azure_credential_config {
    subscription_id = var.azure_subscription_id
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
  }
}


# Resource group containing all resources
resource "azurerm_resource_group" "tf_rg" {
  name     = "${var.prefix}-tf-rg"
  location = var.azure_location

  tags = {
    Creator = "${var.prefix}"
  }
}

# # Azure virtual network space for quickstart resources
# resource "azurerm_virtual_network" "rancher-quickstart" {
#   name                = "${var.prefix}-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.rancher-quickstart.location
#   resource_group_name = azurerm_resource_group.rancher-quickstart.name

#   tags = {
#     Creator = "rancher-quickstart"
#   }
# }

# # Azure internal subnet for quickstart resources
# resource "azurerm_subnet" "rancher-quickstart-internal" {
#   name                 = "rancher-quickstart-internal"
#   resource_group_name  = azurerm_resource_group.rancher-quickstart.name
#   virtual_network_name = azurerm_virtual_network.rancher-quickstart.name
#   address_prefixes     = ["10.0.0.0/16"]
# }

# ## Public IP of quickstart node
# resource "azurerm_public_ip" "quickstart-node-pip" {
#   name                = "quickstart-node-pip"
#   location            = azurerm_resource_group.rancher-quickstart.location
#   resource_group_name = azurerm_resource_group.rancher-quickstart.name
#   allocation_method   = "Dynamic"

#   tags = {
#     Creator = "rancher-quickstart"
#   }
# }

# # Azure network interface for quickstart resources
# resource "azurerm_network_interface" "quickstart-node-interface" {
#   name                = "quickstart-node-interface"
#   location            = azurerm_resource_group.rancher-quickstart.location
#   resource_group_name = azurerm_resource_group.rancher-quickstart.name

#   ip_configuration {
#     name                          = "rancher_server_ip_config"
#     subnet_id                     = azurerm_subnet.rancher-quickstart-internal.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.quickstart-node-pip.id
#   }

#   tags = {
#     Creator = "rancher-quickstart"
#   }
# }
# // ensure computer_name meets 15 character limit
# // uses assumption that resources only use 4 characters for a suffix
# locals {
#   computer_name_prefix = substr(var.prefix, 0, 11)
# }

# # Azure linux virtual machine for creating a single node RKE cluster and installing the Rancher Server
# resource "azurerm_linux_virtual_machine" "quickstart-node" {
#   name                  = "${var.prefix}-quickstart-node"
#   computer_name         = "${local.computer_name_prefix}-qn" // ensure computer_name meets 15 character limit
#   location              = azurerm_resource_group.rancher-quickstart.location
#   resource_group_name   = azurerm_resource_group.rancher-quickstart.name
#   network_interface_ids = [azurerm_network_interface.quickstart-node-interface.id]
#   size                  = var.instance_type
#   admin_username        = local.node_username

#   source_image_reference {
#     publisher = "SUSE"
#     offer     = "sles-15-sp2"
#     sku       = "gen2"
#     version   = "latest"
#   }

#   admin_ssh_key {
#     username   = local.node_username
#     public_key = file("~/.ssh/id_rsa.pub")
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }

#   tags = {
#     Creator = "rancher-quickstart"
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "echo 'Waiting for cloud-init to complete...'",
#       "cloud-init status --wait > /dev/null",
#       "echo 'Completed cloud-init!'",
#     ]

#     connection {
#       type        = "ssh"
#       host        = self.public_ip_address
#       user        = local.node_username
#       private_key = file("~/.ssh/id_rsa")
#     }
#   }
# }
