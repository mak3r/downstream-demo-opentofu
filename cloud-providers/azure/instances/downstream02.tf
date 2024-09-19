# Create azure machine config v2
resource "rancher2_machine_config_v2" "downstream01-config" {
  generate_name = "downstream01-config"
  azure_config {
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
    subscription_id = var.azure_subscription_id
    location = var.azure_location
    resource_group = var.resource_group
    size = var.instance_type
  }
}


# Create a new rancher v2 azure K3s Cluster v2
resource "rancher2_cluster_v2" "azure-downstream" {
  name = "muc"
  kubernetes_version = 	"v1.27.12+k3s1"
  enable_network_policy = false
  default_cluster_role_for_project_members = "user"
  labels = {
    geo = "de"
    city = "munich"
  }
  rke_config {
    machine_pools {
      name = "tf-pool-downstream01"
      cloud_credential_secret_name = var.cloud_credentials
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 3
      machine_config {
        kind = rancher2_machine_config_v2.downstream01-config.kind
        name = rancher2_machine_config_v2.downstream01-config.name
      }
    }
  }
}