module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.29"
  subnets         = var.subnet_ids
  vpc_id          = var.vpc_id

  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 2
      desired_size = 1
      instance_type = "t3.medium"
    }
  }

  manage_aws_auth = true
  aws_auth_roles = [
    {
      rolearn  = var.eks_admin_arn
      username = "eks-admin"
      groups   = ["system:masters"]
    },
    {
      rolearn  = var.eks_readonly_arn
      username = "eks-readonly"
      groups   = ["viewers"]
    }
  ]
}