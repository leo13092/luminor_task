# Если нужны переменные для настройки RBAC
variable "admin_users" {
  description = "Список admin пользователей"
  type        = list(string)
  default     = ["eks-admin"]
}

variable "readonly_users" {
  description = "Список readonly пользователей"
  type        = list(string)
  default     = ["eks-readonly"]
}