module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = "luminor-eks"
  cluster_role_name   = "luminor-eks-cluster-role"
  node_group_name     = "luminor-eks-node-group"
  node_role_name      = "luminor-eks-node-role"
  subnet_ids          = module.vpc.subnet_ids
  node_desired_size   = 1
  node_max_size       = 2
  node_min_size       = 1
  node_instance_types = ["t3.medium"]
  eks_admin_arn    = var.eks_admin_arn
  eks_readonly_arn = var.eks_readonly_arn
  eks_terraform_user_arn = var.eks_terraform_user_arn
}

module "rbac" {
  source = "./modules/rbac"
}

module "atlantis" {
  source         = "./modules/atlantis"
  cluster_name   = module.eks.cluster_name
  github_repo    = var.github_repo
  github_user    = var.github_user
  github_token   = var.github_token
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.subnet_ids
}

module "eks_access" {
  source       = "./modules/eks-access"
  cluster_name = module.eks.cluster_name
  principals = [
    {
      arn        = var.eks_admin_arn
      type       = "STANDARD"
      policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    },
    {
      arn        = var.eks_readonly_arn
      type       = "STANDARD"
      policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminViewPolicy"
    },
    {
      arn        = var.eks_terraform_user_arn
      type       = "STANDARD"
      policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
    }
  ]
  tags = {
    Environment = "dev"
    Project     = "luminor"
  }
}