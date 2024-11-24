provider "aws" {
  region = "us-east-2"
}

resource "aws_dynamodb_table" "cultrai_data" {
  name           = "cultrai_data"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

resource "aws_s3_bucket" "cultrai_storage" {
  bucket = "cultrai-storage-${random_id.bucket_suffix.hex}"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.cultrai_data.name
}

output "s3_bucket_name" {
  value = aws_s3_bucket.cultrai_storage.id
}
