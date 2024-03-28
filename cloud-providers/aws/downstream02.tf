# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "downstream02-config" {
  generate_name = "downstream02-config"
  amazonec2_config {
    ami =  data.aws_ami.suse.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-0e2e4d3d457dbabd1"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "a" 
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
      cloud_credential_secret_name = rancher2_cloud_credential.aws_cred.id
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