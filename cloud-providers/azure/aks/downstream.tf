

resource "rancher2_cloud_credential" "aks-tf-creds" {
  name = "aks-tf-creds"
  azure_credential_config {
    client_id = var.azure_client_id
    client_secret = var.azure_client_secret
    subscription_id = var.azure_subscription_id
  }
}

resource "rancher2_cluster" "aks-downstream" {
  name = "jfk"
  description = "Terraform AKS cluster"
  labels = {
    geo = "ny"
    city = "new-york"
    biz-unit = "data-analytics"
  }
  aks_config_v2 {
    cloud_credential_id = rancher2_cloud_credential.aks-tf-creds.id
    resource_group = var.resource_group
    resource_location = var.azure_location
    dns_prefix = "jfk"
    kubernetes_version = "1.27.7"
    network_plugin = "kubenet"
    load_balancer_sku = "standard"
    node_pools {
      availability_zones = ["1", "2", "3"]
      name = "pool01"
      mode = "System"
      count = 1
      orchestrator_version = "1.27.7"
      os_disk_size_gb = 128
      vm_size = "Standard_DS2_v2"
    }
    node_pools {
      availability_zones = ["1", "2", "3"]
      name = "pool02"
      count = 1
      mode = "User"
      orchestrator_version = "1.27.7"
      os_disk_size_gb = 128
      vm_size = "Standard_DS2_v2"
      max_surge = "25%"
      # enable_auto_scaling = true
      # max_count = 5
      labels = {
        "test1" = "data1"
        "test2" = "data2"
      }
      taints = [ "none:PreferNoSchedule" ]
    }
  }
}