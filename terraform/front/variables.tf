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

variable "css_path" {
  description = "Path to the CSS file to be uploaded to S3"
  type        = string
}

variable "js_path" {
  description = "Path to the JavaScript file to be uploaded to S3"
  type        = string
}

variable "html_path" {
  description = "Path to the HTML file to be uploaded to S3"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC for health check access"
  type        = string
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for DNS validation"
  type        = string
}
