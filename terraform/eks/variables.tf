variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-3"
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "srvc_pdb_image_url" {
  description = "Docker image URL for the pdb service"
  type        = string
  default     = "ghcr.io/TheRayquaza/aws-training/gfp-pdb:latest"
}

variable "srvc_account_image_url" {
  description = "Docker image URL for the account service"
  type        = string
  default     = "ghcr.io/TheRayquaza/aws-training/gfp-account:latest"
}


variable "redis_endpoint" {
  description = "The endpoint of the Redis cluster"
  type        = string
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
  default     = "gfp-cluster"
}

variable "local_workstation_cidr" {
  description = "CIDR block of the local workstation to allow access to the EKS cluster"
  type        = string
  default     = "89.87.58.213/32"
}

variable "igw_id" {
  description = "Internet Gateway ID for the VPC"
  type        = string
}
