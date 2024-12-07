resource "aws_s3_bucket" "test" {
  bucket = "test"

  tags = {
    Name        = "dev-bucket"
    Environment = "Dev"
  }
}
