# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "downstream02-config" {
  generate_name = "downstream02-config"
  azure_config {
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
    subscription_id = var.azure_subscription_id
    location = var.azure_location
    resource_group = azurerm_resource_group.tf_rg.name
    size = var.instance_type
  }
}

# Create a new rancher v2 amazon ec2 RKE2 Cluster v2
resource "rancher2_cluster_v2" "downstream02" {
  name = "downstream02"
  kubernetes_version = 	"v1.26.12+k3s1"
  enable_network_policy = false
  default_cluster_role_for_project_members = "user"
  labels = {
    geo = "ny"
  }
  rke_config {
    machine_pools {
      name = "pool1"
      cloud_credential_secret_name = rancher2_cloud_credential.azure_cred.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 1
      machine_config {
        kind = rancher2_machine_config_v2.downstream02-config.kind
        name = rancher2_machine_config_v2.downstream02-config.name
      }
    }
  }
}