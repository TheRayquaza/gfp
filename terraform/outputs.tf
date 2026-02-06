# Redis outputs

output "redis_endpoint" {
  description = "The endpoint of the Redis cluster"
  value       = module.cache.redis_endpoint
}

# DB outputs

output "rds_endpoint" {
  description = "The endpoint of the RDS database"
  value       = module.rds.rds_endpoint
}

# Frontend outputs

output "cloudfront_domain_name" {
  description = "The domain name of the CloudFront distribution"
  value       = module.front.cloudfront_domain_name
}

# EKS outputs

output "eks_cluster_name" {
  description = "The name of the EKS cluster"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint for the EKS cluster"
  value       = module.eks.eks_cluster_endpoint
}

# S3 outputs

output "pdb_storage_bucket" {
  description = "The name of the S3 bucket for PDB storage"
  value       = module.s3.pdb_storage_bucket
}
