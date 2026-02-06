resource "aws_s3_bucket" "pdb_storage" {
  bucket = "pdb-data-lake"

  tags = {
    Name        = "PDB Storage"
  }
}

resource "aws_s3_bucket_public_access_block" "pdb_storage_access" {
  bucket = aws_s3_bucket.pdb_storage.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "pdb_storage_versioning" {
  bucket = aws_s3_bucket.pdb_storage.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "pdb_storage_crypto" {
  bucket = aws_s3_bucket.pdb_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_cors_configuration" "pdb_storage_cors" {
  bucket = aws_s3_bucket.pdb_storage.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = ["https://gfp.rayq.app"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
resource "aws_s3_bucket_lifecycle_configuration" "pdb_storage_lifecycle" {
  bucket = aws_s3_bucket.pdb_storage.id

  rule {
    id     = "Expire old PDB files"
    status = "Enabled"

    expiration {
      days = 30
    }

    filter {
      prefix = "pdb_files/"
    }
  }
}
