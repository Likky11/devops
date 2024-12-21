provider "aws" {
  region = "us-east-1"  # Specify the correct region for your use case
}
resource "aws_s3_bucket" "test" {
  bucket = "test"

  tags = {
    Name        = "dev-bucket"
    Environment = "Dev"
   
  }
}