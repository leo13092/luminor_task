# AWS Configuration
aws_region = "eu-central-1"

# GitHub Configuration for Atlantis
github_repo  = "your-username/your-repo-name"
github_user  = "your-github-username"
github_token = "ghp_your_github_personal_access_token_here"

# IAM Role ARNs for EKS Access
# Replace with your actual IAM role ARNs
eks_admin_arn    = "arn:aws:iam::123456789012:role/eks-admin-role"
eks_readonly_arn = "arn:aws:iam::123456789012:role/eks-readonly-role" 