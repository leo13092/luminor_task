resource "aws_eks_access_entry" "this" {
  for_each = { for idx, principal in var.principals : principal.arn => principal }

  cluster_name  = var.cluster_name
  principal_arn = each.value.arn
  type          = each.value.type
  tags          = var.tags
}

resource "aws_eks_access_policy_association" "this" {
  for_each = { for idx, principal in var.principals : principal.arn => principal }

  cluster_name  = var.cluster_name
  principal_arn = aws_eks_access_entry.this[each.key].principal_arn
  policy_arn    = each.value.policy_arn
  access_scope {
    type = "cluster"
  }
}