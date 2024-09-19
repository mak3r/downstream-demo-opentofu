# # Create a new Rancher2 App V2 using
# resource "rancher2_app_v2" "neuvector" {
#   cluster_id = rancher2_cluster.aks-downstream.id
#   name = "neuvector"
#   namespace = "neuvector"
#   repo_name = "rancher-charts"
#   chart_name = "neuvector"
#   chart_version = "103.0.3+up2.7.6"
#   values = file("cloud-providers/azure/aks/neuvector-values.yaml")
# }

# # Create a new Rancher2 App V2 using
# resource "rancher2_app_v2" "rancher-monitoring" {
#   cluster_id = rancher2_cluster.aks-downstream.id
#   name = "rancher-monitoring"
#   namespace = "cattle-monitoring-system"
#   repo_name = "rancher-charts"
#   chart_name = "rancher-monitoring"
#   chart_version = "103.0.4+up45.31.1"
#   #values = file("values.yaml")
# }