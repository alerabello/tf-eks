# CLUSTER
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The desired Kubernetes master version (EX: '1.30')"
  type        = string
}

variable "node_group_subnet_ids" {
  description = "The name of the EKS node group"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  validation {
    condition     = try(var.tags.Name, "") == ""
    error_message = "value of 'Name' tag must be set using the 'cluster_name' variable"
  }
  default = null
}

# VPC E SUBNETS
variable "vpc_id" {
  description = "The VPC ID where the EKS cluster will be deployed"
  type        = string
}

variable "control_plane_subnet_ids" {
  description = "A list of subnet IDs to launch the EKS control plane into"
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch the EKS nodes into"
  type        = list(string)
}

# Logs e Monitorias EKS
variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logging to enable"
  type        = list(string)
}

variable "cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data"
  type        = string
}

variable "cloudwatch_log_group_retention_in_days" {
  description = "The number of days to retain log events"
  type        = number
}

variable "enable_irsa" {
  description = "Whether to enable IAM Roles for Service Accounts for your cluster"
  type        = bool
}

# Auth e Roles Acess EKS
variable "access_entries" {
  description = "IAM Role entries to add to the aws-auth configmap"
  type = list(object({
    role_arn = string
    username = string
    groups   = list(string)
  }))
}

# IAM e Roles EKS
variable "cluster_encryption_policy_use_name_prefix" {
  description = "Whether to use a name prefix for the default encryption policy for the EKS cluster"
  type        = bool
  default     = false
}

variable "iam_role_use_name_prefix" {
  description = "Whether to use a name prefix for the IAM roles"
  type        = bool
  default     = false
}

