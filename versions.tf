terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws        = ">= 4.0"
    kubernetes = ">= 2.0"
    helm       = ">= 2.0"
  }
}