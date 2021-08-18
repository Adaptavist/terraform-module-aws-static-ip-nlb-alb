data "aws_iam_policy_document" "populate_target_group" {
  # checkov:skip=CKV_AWS_111:putMetricData is available on all resources
  statement {
    actions = [
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
    ]

    resources = [module.aws-s3-encrypted-private.bucket_arn]
    effect    = "Allow"
    sid       = "S3"
  }

  statement {
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]

    resources = [var.alb_arn, var.nlb_arn]
    effect    = "Allow"
    sid       = "ELB"
  }

  statement {
    actions   = ["cloudwatch:putMetricData"]
    resources = ["*"]
    effect    = "Allow"
    sid       = "CloudWatch"
  }
}

resource "aws_iam_policy" "populate_target_group" {
  name        = "nlb-target-group-configurer-policy"
  description = "Allows Lambda to populate NLB target groups with ALB dynamic IPs"
  policy      = data.aws_iam_policy_document.populate_target_group.json
}

