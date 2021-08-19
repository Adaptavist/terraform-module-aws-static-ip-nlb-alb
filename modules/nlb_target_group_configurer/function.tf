resource "aws_kms_key" "function" {
  description             = "NLB Target Group Configurer Function Key"
  enable_key_rotation     = true
  deletion_window_in_days = 7
  tags                    = var.tags
}

module "nlb-target-group-configurer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "2.1.0"

  function_name = "nlb-target-group-configurer"
  handler       = "populate_NLB_TG_with_ALB.lambda_handler"
  runtime       = "python3.8"
  description   = "Populates NLB target groups with ALB dynamic IPs"
  timeout       = 300

  create_package         = false
  local_existing_package = "${path.module}/populate_NLB_TG_with_ALB_python3.zip"

  create_role = true
  role_name   = "nlb-target-group-configurer-role"
  //attach_network_policy         = true
  attach_cloudwatch_logs_policy = true
  attach_policies               = true
  number_of_policies            = 3
  policies = [
    aws_iam_policy.populate_target_group.arn,
    module.aws-s3-encrypted-private.s3_write_policy_arn,
    module.aws-s3-encrypted-private.s3_read_policy_arn
  ]

  environment_variables = {
    ALB_DNS_NAME                      = var.alb_dns_name
    ALB_LISTENER                      = var.alb_listener_port
    S3_BUCKET                         = module.aws-s3-encrypted-private.bucket_name
    NLB_TG_ARN                        = var.nlb_target_group_arn
    MAX_LOOKUP_PER_INVOCATION         = var.max_lookup_per_invocation
    INVOCATIONS_BEFORE_DEREGISTRATION = var.invocations_before_deregistration
    CW_METRIC_FLAG_IP_COUNT           = var.cw_metric_flag_ip_count
  }

  use_existing_cloudwatch_log_group = false
  //cloudwatch_logs_kms_key_id        = aws_kms_key.function.arn
  cloudwatch_logs_retention_in_days = 14

  tags = var.tags
}
