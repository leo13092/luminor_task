variable "aws_region" {
  description = "AWS region"
  default     = "eu-central-1"
}

variable "github_repo" {
  description = "GitHub repository for integration with Atlantis"
  type        = string
}

variable "github_user" {
  description = "GitHub username for Atlantis integration"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token for Atlantis"
  type        = string
  sensitive   = true
}

variable "eks_admin_arn" {
  description = "ARN of the IAM role for EKS admin access"
  type        = string
}

variable "eks_readonly_arn" {
  description = "ARN of the IAM role for EKS read-only access"
  type        = string
}