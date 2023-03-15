terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.58.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "ibekittenS" {
  bucket = "kittens.ibrahimu.net"
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.ibekittenS.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      aws_s3_bucket.ibekittenS.arn,
      "${aws_s3_bucket.ibekittenS.arn}/*",
    ]
  }
}

resource "aws_s3_bucket_website_configuration" "ibekittenS" {
  bucket = aws_s3_bucket.ibekittenS.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }

}

resource "aws_s3_bucket_public_access_block" "ibekittenSe" {
  bucket = aws_s3_bucket.ibekittenS.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}