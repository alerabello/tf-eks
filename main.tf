module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.11.1"

    cluster_name = var.cluster_name
    cluster_version = var.cluster_version
    # VPC'S e Subnet's EKS
    vpc_id = var.vpc_id
    subnet_ids = var.subnet_ids
    control_plane_subnet_ids = var.control_plane_subnet_ids

    #Logs e Monitorias EKS
    cluster_enabled_log_types = var.cluster_enabled_log_types
    cloudwatch_log_group_kms_key_id = var.cloudwatch_log_group_kms_key_id
    cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
    enable_irsa = var.enable_irsa

    # Auth e Roles Acess EKS
    access_entries = var.access_entries

    # IAM e Roles EKS
    cluster_encryption_policy_use_name_prefix = false
    iam_role_use_name_prefix = false
}