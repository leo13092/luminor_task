# EKS Access Module

This module manages IAM principal access to EKS clusters using AWS EKS Access Entries and Policy Associations.

## Usage

```hcl
module "eks_access" {
  source       = "./modules/eks-access"
  cluster_name = module.eks.cluster_name
  principals = [
    {
      arn        = "arn:aws:iam::123456789012:user/admin"
      type       = "STANDARD"
      policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    },
    {
      arn        = "arn:aws:iam::123456789012:role/readonly"
      type       = "STANDARD"
      policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterViewPolicy"
    }
  ]
  tags = {
    Environment = "production"
    Project     = "luminor"
  }
}
```

## Variables

- `cluster_name` - Name of the EKS cluster
- `principals` - List of IAM principals with their access policies
- `tags` - Tags to apply to resources

## Outputs

- `access_entries` - List of created access entries
- `access_policy_associations` - List of policy associations
- `admin_principals` - List of admin principals
- `readonly_principals` - List of read-only principals 