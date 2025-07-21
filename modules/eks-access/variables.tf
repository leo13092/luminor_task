variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "principals" {
  description = "List of IAM principals to grant access to the cluster"
  type = list(object({
    arn        = string
    type       = string
    policy_arn = string
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

