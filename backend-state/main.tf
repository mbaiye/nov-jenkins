variable "aws_region" {
  default = "us-east-2"
  
}


provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-mobann-jenkins"
  
  tags = {
    Name = "terraform-state-mobann-jenkins"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  
  versioning_configuration {
    status = "Enabled"
  }
  
}