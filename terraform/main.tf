locals {
  css_files = sort(fileset(path.module, "../apps/srvc-front/dist/assets/index*.css"))
  css_path  = length(local.css_files) > 0 ? abspath(local.css_files[0]) : "not-found"
  js_files = sort(fileset(path.module, "../apps/srvc-front/dist/assets/index*.js"))
  js_path  = length(local.js_files) > 0 ? abspath(local.js_files[0]) : "not-found"
  html_path = abspath("../apps/srvc-front/dist/index.html")
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "gfp-igw"
  }
}

module "eks" {
  source = "./eks"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region

  vpc_id = aws_vpc.main.id
  redis_endpoint = module.cache.redis_endpoint
  igw_id = aws_internet_gateway.igw.id
  local_workstation_cidr = var.local_workstation_cidr

  depends_on = [ aws_vpc.main ]
}

module "cache" {
  source = "./cache"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region

  vpc_id = aws_vpc.main.id
  eks_worker_sg_ids = module.eks.eks_worker_sg_ids
}

module "s3" {
  source = "./s3"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region
}

module "rds" {
  source = "./rds"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region

  vpc_id = aws_vpc.main.id
  eks_worker_sg_ids = module.eks.eks_worker_sg_ids

  depends_on = [ module.eks, aws_vpc.main ]
}

module "front" {
  source = "./front"

  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  region = var.region

  # CloudFront
  css_path = local.css_path
  js_path  = local.js_path
  html_path = local.html_path

  # Cloudflare Certificate DNS Validation
  cloudflare_zone_id = var.cloudflare_zone_id

  # VPC
  vpc_id = aws_vpc.main.id
  vpc_cidr = aws_vpc.main.cidr_block
}
