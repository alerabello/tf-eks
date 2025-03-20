module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  # VPC'S e Subnet's EKS
  vpc_id                   = var.vpc_id
  subnet_ids               = var.subnet_ids
  control_plane_subnet_ids = var.control_plane_subnet_ids

  #Logs e Monitorias EKS
  cluster_enabled_log_types              = var.cluster_enabled_log_types
  cloudwatch_log_group_kms_key_id        = var.cloudwatch_log_group_kms_key_id
  cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
  enable_irsa                            = var.enable_irsa

  # Auth e Roles Acess EKS
  enable_cluster_creator_admin_permissions = true
  access_entries = var.access_entries
  authentication_mode = "API_AND_CONFIG_MAP"

  # IAM e Roles EKS
  cluster_encryption_policy_use_name_prefix = false
  iam_role_use_name_prefix                  = false

  #Tags EKS
  cluster_tags = var.cluster_tags
  tags = var.tags

  #Addons e Endpoints EKS
  cluster_endpoint_public_access = true
  cluster_addons = {
    vpc-cni = {
      enabled = true
      most_recent = true
    }
    kube-proxy = {
      enabled = true
      most_recent = true
    }
    coredns = {
      enabled = true
      most_recent = true
    }
  }
  
  # EKS NODES GROUP
  eks_managed_node_groups = {
    eks-api-test ={
      iam_role_use_name_prefix = false
      use_name_prefix = false
      name = "eks-api-test"
      min_size = 1
      max_size = 50
      desired_capacity = 1
      instance_types = ["t3.medium"]
      ami_type = "AL2_x86_64"
      capacity_type = "ON_DEMAND"
      ebs_optimized = true
      enable_monitoring = true
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            encrypted = true
            volume_size = 30
            volume_type = "gp3"
            iops = 3000
            throughput = 150
            delete_on_termination = true
          }
        }
      }
      update_config = {
        max_unavailable_percentage = 33 # or set max_unavailable
      }
      iam_role_additional_policies = {
        "AmazonEC2FullAccess" = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
      }
    }
  }
}