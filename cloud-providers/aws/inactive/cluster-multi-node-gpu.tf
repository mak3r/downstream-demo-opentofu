
# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "mn_zone_a" {
  generate_name = "mn-zone-a"
  amazonec2_config {
    ami =  data.aws_ami.suse.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-0e2e4d3d457dbabd1"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "a" 
  }
}

# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "mn_zone_b" {
  generate_name = "mn-zone-b"
  amazonec2_config {
    ami =  data.aws_ami.suse.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-02eaea143a5ce08a9"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "b" 
  }
}

# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "mn_zone_c" {
  generate_name = "mn-zone-c"
  amazonec2_config {
    ami =  data.aws_ami.suse.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-02f406869c0d7b100"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "c" 
  }
}

# Create amazonec2 machine config v2
resource "rancher2_machine_config_v2" "mn-gpu-machine-config" {
  generate_name = "mn-gpu-machine-config"
  amazonec2_config {
    ami =  data.aws_ami.gpu-ubuntu.id
    region = var.aws_region
    security_group = [aws_security_group.sg_demo_allowall.name]
    subnet_id = "subnet-02eaea143a5ce08a9"
    vpc_id = "vpc-0ba65b05ffd4faadb"
    zone = "b" 
    instance_type = "p3.2xlarge" #V100 GPU
    volume_type = "gp2"
    userdata = file("./cloud.config") # includes ssh keys
  }
}

# Create a new rancher v2 amazon ec2 RKE2 Cluster v2
resource "rancher2_cluster_v2" "multi-node-gpu" {
  name = "multi-node-gpu"
  #kubernetes_version = "v1.27.11+k3s1"
  kubernetes_version = "v1.26.12+k3s1"
  enable_network_policy = false
  default_cluster_role_for_project_members = "user"
  labels = {
    geo = "ny"
  }
  rke_config {
    machine_pools {
      name = "gpu-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.aws_cred.id
      control_plane_role = false
      etcd_role = false
      worker_role = true
      quantity = 1
      machine_config {
        kind = rancher2_machine_config_v2.mn-gpu-machine-config.kind
        name = rancher2_machine_config_v2.mn-gpu-machine-config.name
      }
    }
    # Each machine pool must be passed separately
    machine_pools {
      name = "std-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.aws_cred.id
      control_plane_role = false
      etcd_role = false
      worker_role = true
      quantity = 1
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.mn_zone_b.kind
        name = rancher2_machine_config_v2.mn_zone_b.name
      }
    }
    machine_pools {
      name = "control-plane-pool"
      cloud_credential_secret_name = rancher2_cloud_credential.aws_cred.id
      control_plane_role = true
      etcd_role = true
      worker_role = true
      quantity = 1
      drain_before_delete = true
      machine_config {
        kind = rancher2_machine_config_v2.mn_zone_c.kind
        name = rancher2_machine_config_v2.mn_zone_c.name
      }
    }
  }
}