output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = aws_eks_cluster.gfp-cluster.name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = aws_eks_cluster.gfp-cluster.endpoint
}

output "eks_worker_sg_ids" {
  description = "The security group IDs associated with the EKS worker nodes"
  value       = [for sg in aws_eks_cluster.gfp-cluster.vpc_config[0].security_group_ids : sg]
}

output "eks_cluster_subnet_ids" {
  description = "The subnet IDs associated with the EKS cluster"
  value       = [for subnet in aws_eks_cluster.gfp-cluster.vpc_config[0].subnet_ids : subnet]
}
