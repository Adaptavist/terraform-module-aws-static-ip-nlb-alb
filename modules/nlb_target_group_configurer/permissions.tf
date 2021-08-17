data "aws_iam_policy_document" "populate_target_group" {
  statement {
    actions = [
      "s3:Get*",
      "s3:PutObject",
      "s3:CreateBucket",
      "s3:ListBucket",
      "s3:ListAllMyBuckets",
    ]

    resources = ["*"]
    effect    = "Allow"
    sid       = "S3"
  }

  statement {
    actions = [
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterTargets",
      "elasticloadbalancing:DeregisterTargets",
    ]

    resources = ["*"]
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

