# ClusterRole для readonly пользователей
resource "kubernetes_cluster_role" "eks_readonly" {
  metadata {
    name = "eks-readonly"
  }
  rule {
    api_groups = [""]
    resources  = ["pods", "services", "configmaps", "secrets"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["apps"]
    resources  = ["deployments", "replicasets", "statefulsets"]
    verbs      = ["get", "list", "watch"]
  }
  rule {
    api_groups = ["networking.k8s.io"]
    resources  = ["ingresses", "networkpolicies"]
    verbs      = ["get", "list", "watch"]
  }
}

# ClusterRoleBinding для readonly роли
resource "kubernetes_cluster_role_binding" "eks_readonly" {
  metadata {
    name = "eks-readonly-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.eks_readonly.metadata[0].name
  }
  subject {
    kind      = "User"
    name      = "eks-readonly"
    api_group = "rbac.authorization.k8s.io"
  }
}

# ClusterRoleBinding для admin роли (использует встроенную роль cluster-admin)
resource "kubernetes_cluster_role_binding" "eks_admin" {
  metadata {
    name = "eks-admin-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "eks-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}