provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "cluster" {
  name       = module.eks.cluster_name
  depends_on = [module.eks]
}

provider "kubernetes" {
  config_path = "/Users/admin/.kube/config"
}

provider "helm" {
  kubernetes = {
    config_path = "/Users/admin/.kube/config"
  }
}