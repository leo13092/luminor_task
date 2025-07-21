# Luminor EKS + Atlantis Infrastructure

## Preliminary

Before you start, make sure you have:

1. **An AWS account** — Register at https://aws.amazon.com/ if you don't have one.
2. **An IAM user** — Create a user in the AWS Console with programmatic access and attach the necessary policies (e.g., AdministratorAccess for initial setup).
3. **Two IAM roles** —
   - **Admin role** (for cluster administrators)
   - **Read-only role** (for users with view-only access)
   
   Both roles should have trust relationships allowing them to be assumed by your users or groups as needed. Attach appropriate EKS policies (e.g., `AmazonEKSClusterAdminPolicy` for admin, `AmazonEKSClusterViewPolicy` for read-only, or custom policies if required).
4. Create custom policies in AWS and attach them to terrafrom-user:
   ```
   {
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "AllowPassRoleForEKSAccess",
			"Effect": "Allow",
			"Action": "iam:PassRole",
			"Resource": [
				"arn:aws:iam::020510964969:role/eks-admin-role",
				"arn:aws:iam::020510964969:role/eks-readonly-role"
			]
		}
	]
   }
   ```

and

```
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "FullEKSAccess",
			"Effect": "Allow",
			"Action": [
				"eks:*"
			],
			"Resource": "*"
		},
		{
			"Sid": "IAMAccessForEKS",
			"Effect": "Allow",
			"Action": [
				"iam:GetRole",
				"iam:PassRole",
				"iam:ListRoles"
			],
			"Resource": "*"
		},
		{
			"Sid": "SSMAndEC2Describe",
			"Effect": "Allow",
			"Action": [
				"ec2:DescribeSubnets",
				"ec2:DescribeVpcs",
				"ec2:DescribeSecurityGroups",
				"ec2:DescribeRouteTables",
				"ec2:DescribeInternetGateways",
				"ssm:GetParameter",
				"ssm:GetParameters",
				"ssm:GetParameterHistory"
			],
			"Resource": "*"
		},
		{
			"Sid": "STSAssumeRoles",
			"Effect": "Allow",
			"Action": [
				"sts:AssumeRole"
			],
			"Resource": "*"
		}
	]
}
```

6. **A GitHub Personal Access Token** — For Atlantis integration.

### Example `terraform.tfvars`
```hcl
aws_region              = "eu-central-1"
github_repo             = "your/repo"
github_user             = "your-github-user"
github_token            = "your-github-token"
eks_admin_arn           = "arn:aws:iam::123456789012:role/eks-admin-role"
eks_readonly_arn        = "arn:aws:iam::123456789012:role/eks-readonly-role"
eks_terraform_user_arn  = "arn:aws:iam::123456789012:user/terraform-user"
```

## Description

This project deploys AWS EKS infrastructure and installs Atlantis to automate Terraform workflows via GitHub Pull Requests.

## Components
- VPC with two public subnets and an Internet Gateway
- EKS cluster with autoscaling managed node group
- RBAC with admin and read-only roles (via Kubernetes RBAC)
- Atlantis is installed via Helm
- IAM user and role access to EKS is managed via the `eks-access` module (AWS EKS Access Entry/Policy Association)
- The `aws-auth` ConfigMap is managed via Terraform

## Quick Start

1. Clone the repository and navigate to the project directory
2. Fill in variables in `terraform.tfvars` or via environment variables
3. Make sure your AWS credentials are set and your IAM user is specified in the config
4. Run:

```sh
make init
make apply
```

## Variables
- `aws_region` — AWS region
- `github_repo` — GitHub repository (not used in Helm values)
- `github_user` — GitHub username for Atlantis
- `github_token` — GitHub Personal Access Token (used as `github.secret` for Atlantis)
- `eks_admin_arn` — ARN of the IAM role for admins
- `eks_readonly_arn` — ARN of the IAM role for read-only
- `eks_terraform_user_arn` — ARN of the IAM user for Terraform

## Important
- Access to the EKS cluster is managed via the `eks-access` module (`aws_eks_access_entry` and `aws_eks_access_policy_association` resources).
- For correct access management, use only those policyArn values that actually exist in your region (check with `aws eks list-access-policies`).
- The `aws-auth` ConfigMap is managed via Terraform. If you get an "already exists" error, delete it manually or import it into Terraform.
- For Atlantis, the GitHub token parameter is passed as `github.secret` (not `github.token` or `repo`).
- The `kubernetes` and `helm` providers use your local kubeconfig (`~/.kube/config`). Make sure your user has `system:masters` rights to manage the cluster.
- If you get permission errors for the terraform-user, check that it is listed in aws-auth with the `system:masters` group.

## Atlantis Check
Create a Pull Request with any change to a Terraform file — Atlantis will automatically react.

## Destroy
```sh
make destroy
``` 
