# Luminor EKS + Atlantis Infrastructure

## Description

This project deploys AWS EKS infrastructure and installs Atlantis to automate Terraform workflows via GitHub Pull Requests.

## Components
- VPC with two subnets
- EKS cluster with autoscaling worker nodes
- RBAC with admin and read-only roles
- Atlantis installed via Helm

## Quick Start

1. Clone the repository and navigate to the project directory
2. Fill in variables in `terraform.tfvars` or via environment variables
3. Run:

```sh
make init
make apply
```

## Variables
- `aws_region` — AWS region
- `github_repo` — GitHub repository
- `github_user` — GitHub username
- `github_token` — GitHub Personal Access Token
- `eks_admin_arn` — ARN of the IAM role for admins
- `eks_readonly_arn` — ARN of the IAM role for read-only

## Atlantis Check
Create a Pull Request with any change to a Terraform file — Atlantis will automatically react.

## Destroy
```sh
make destroy
``` 