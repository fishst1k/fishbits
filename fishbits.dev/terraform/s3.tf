resource "aws_s3_bucket" "tf_state" {
  bucket = "fishbits-terraform-state"

  tags = {
    Name        = "fishbits-terraform-state"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_ownership_controls" "tf_state_ownership_controls" {
  bucket = aws_s3_bucket.tf_state.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "tf_state_acl" {
  bucket = aws_s3_bucket.tf_state.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "terraform_policy" {
    statement {
        principals {
          type = "AWS"
          identifiers = [var.user_role_arn]
        }

        actions = [
            "s3:ListBucket"
        ]

        resources = [
            aws_s3_bucket.tf_state.arn
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
            "${aws_s3_bucket.tf_state.arn}/*"
        ]
    }
}

resource "aws_s3_bucket_policy" "terraform_policy" {
  depends_on = [
    data.aws_iam_policy_document.terraform_policy,
    aws_s3_bucket.tf_state
  ]
  bucket = aws_s3_bucket.tf_state.id
  policy = data.aws_iam_policy_document.terraform_policy.json
}
