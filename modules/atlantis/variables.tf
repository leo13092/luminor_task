variable "github_user" {
  description = "GitHub username for Atlantis integration"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token for Atlantis"
  type        = string
  sensitive   = true
}

variable "github_repo" {
  description = "GitHub repository for integration with Atlantis"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
} 