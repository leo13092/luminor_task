output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_ids" {
  value = aws_subnet.public[*].id
}

output "eks_nodes_sg_id" {
  value = aws_security_group.eks_nodes.id
} 