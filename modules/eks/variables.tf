variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_role_name" {
  description = "IAM role name for EKS cluster"
  type        = string
}

variable "node_group_name" {
  description = "Node group name"
  type        = string
}

variable "node_role_name" {
  description = "IAM role name for node group"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Desired number of nodes"
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of nodes"
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of nodes"
  type        = number
}

variable "node_instance_types" {
  description = "Instance types for node group"
  type        = list(string)
}

variable "eks_admin_arn" {
  description = "ARN of the IAM role for EKS admin access"
  type        = string
}

variable "eks_readonly_arn" {
  description = "ARN of the IAM role for EKS read-only access"
  type        = string
} 

variable "eks_terraform_user_arn" {
  description = "ARN of the IAM user for EKS Terraform access"
  type        = string
}