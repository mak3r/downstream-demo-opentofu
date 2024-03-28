

# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "aio-gpu-machine-config-1b" {
  generate_name = "aio-gpu-machine-config"
  amazonec2_config {
    ami =  data.aws_ami.gpu-ubuntu.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-02eaea143a5ce08a9"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "b" 
    # NOTE: Uses 16 vCPU with 16 GPU memory and 64 GB RAM
    instance_type = "g4dn.4xlarge" #required due to capping out resources on p3.2xlarge - T4 GPU
    volume_type = "gp2"
  }
}


# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "aio-gpu-machine-config-1d" {
  generate_name = "aio-gpu-machine-config"
  amazonec2_config {
    ami =  data.aws_ami.gpu-ubuntu.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-021254f8810133a0f"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "d" 
    # NOTE: p3.8xlarge uses 32 vCPU and you must have credentials which allow provisioning of this magnitude
    instance_type = "p3.8xlarge" #required due to capping out resources on p3.2xlarge - V100 GPU
    volume_type = "gp2"
  }
}


# Create a new rancher v2 amazon ec2 RKE2 Cluster v2
resource "rancher2_cluster_v2" "all-in-one-gpu" {
  name = "all-in-one-gpu"
  kubernetes_version = 	"v1.26.10+rke2r2"
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
        kind = rancher2_machine_config_v2.aio-gpu-machine-config-1b.kind
        name = rancher2_machine_config_v2.aio-gpu-machine-config-1b.name
      }
    }
  }
}