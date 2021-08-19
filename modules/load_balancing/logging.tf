module "aws-s3-alb-logs" {
  source    = "cloudposse/lb-s3-bucket/aws"
  version   = "0.13.0"
  namespace = var.name
  stage     = var.tags["Avst:Stage:Name"]
  name      = "lb-logs"
  tags      = var.tags
}

resource "aws_s3_bucket_policy" "access_logs" {
  bucket = module.aws-s3-alb-logs.bucket_id

  policy = data.aws_iam_policy_document.access_logs.json
}

data "aws_elb_service_account" "elb_account" {}
data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "access_logs" {
  statement {
    actions = [
      "s3:PutObject"
    ]

    principals {
      identifiers = [data.aws_elb_service_account.elb_account.arn]
      type        = "AWS"
    }

    resources = [
      "arn:aws:s3:::${module.aws-s3-alb-logs.bucket_id}/public/AWSLogs/${data.aws_caller_identity.this.account_id}/*",
      "arn:aws:s3:::${module.aws-s3-alb-logs.bucket_id}/private/AWSLogs/${data.aws_caller_identity.this.account_id}/*"
    ]
  }

  statement {
    actions = [
      "s3:PutObject"
    ]

    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }

    resources = [
      "arn:aws:s3:::${module.aws-s3-alb-logs.bucket_id}/public/AWSLogs/${data.aws_caller_identity.this.account_id}/*",
      "arn:aws:s3:::${module.aws-s3-alb-logs.bucket_id}/private/AWSLogs/${data.aws_caller_identity.this.account_id}/*"
    ]
    condition {
      test     = "StringEquals"
      values   = ["bucket-owner-full-control"]
      variable = "s3:x-amz-acl"
    }
  }

  statement {
    actions = [
      "s3:GetBucketAcl"
    ]

    principals {
      identifiers = ["delivery.logs.amazonaws.com"]
      type        = "Service"
    }

    resources = [
      "arn:aws:s3:::${module.aws-s3-alb-logs.bucket_id}"
    ]
  }
}
