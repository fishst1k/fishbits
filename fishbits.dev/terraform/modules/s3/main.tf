resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = var.tags
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "s3_bucket" {
    statement {
        principals {
          type = "AWS"
          identifiers = [var.user_role_arn]
        }

        actions = [
            "s3:ListBucket"
        ]

        resources = [
            aws_s3_bucket.s3_bucket.arn
        ]
    }

    statement {
        principals {
          type = "AWS"
          identifiers = [var.user_role_arn]
        }

        actions = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]

        resources = [
            "${aws_s3_bucket.s3_bucket.arn}/*"
        ]
    }
}

resource "aws_s3_bucket_policy" "s3_bucket" {
  depends_on = [
    data.aws_iam_policy_document.s3_bucket,
    aws_s3_bucket.s3_bucket
  ]
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket.json
}
