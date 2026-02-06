output "pdb_storage_bucket" {
  description = "The name of the PDB storage S3 bucket"
  value       = aws_s3_bucket.pdb_storage.bucket
}
