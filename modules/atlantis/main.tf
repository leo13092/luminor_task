resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  namespace  = "atlantis"
  create_namespace = true

  set {
    name  = "github.user"
    value = var.github_user
  }
  set {
    name  = "github.token"
    value = var.github_token
  }
  set {
    name  = "github.repo"
    value = var.github_repo
  }
  set {
    name  = "orgWhitelist"
    value = "github.com/${var.github_user}"
  }
}