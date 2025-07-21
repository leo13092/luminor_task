resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  namespace  = "atlantis"
  create_namespace = true

set = [
  {
    name  = "github.user"
    value = var.github_user
  },
  {
    name  = "github.token"
    value = var.github_token
  },
  {
    name  = "github.secret"
    value = "supersecret"
  }
]
}