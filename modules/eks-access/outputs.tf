output "access_entries" {
  description = "List of created EKS access entries"
  value = {
    for k, v in aws_eks_access_entry.this : k => {
      cluster_name    = v.cluster_name
      principal_arn   = v.principal_arn
      type           = v.type
    }
  }
}

output "access_policy_associations" {
  description = "List of EKS access policy associations"
  value = {
    for k, v in aws_eks_access_policy_association.this : k => {
      cluster_name  = v.cluster_name
      principal_arn = v.principal_arn
      policy_arn    = v.policy_arn
    }
  }
}

output "admin_principals" {
  description = "List of principal ARNs with admin access"
  value = [
    for k, v in aws_eks_access_policy_association.this : v.principal_arn
    if v.policy_arn == "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  ]
}

output "readonly_principals" {
  description = "List of principal ARNs with read-only access"
  value = [
    for k, v in aws_eks_access_policy_association.this : v.principal_arn
    if v.policy_arn == "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterViewPolicy"
  ]
}
