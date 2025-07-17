module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source          = "./modules/eks"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.subnet_ids
  cluster_name    = "luminor-eks"
  eks_admin_arn   = var.eks_admin_arn
  eks_readonly_arn = var.eks_readonly_arn
}

module "rbac" {
  source = "./modules/rbac"
  depends_on = [module.eks]
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