module "aws-s3-encrypted-private" {
  source  = "Adaptavist/aws-s3-encrypted-private/module"
  version = "1.2.0"

  bucket_suffix             = "${var.name}-nlb-config-${var.tags["Avst:Stage:Name"]}"
  use_bucket_suffix_as_name = true
  kms_user_role_arns        = [module.nlb-target-group-configurer.lambda_role_arn]
  kms_admin_role_arns       = []
}