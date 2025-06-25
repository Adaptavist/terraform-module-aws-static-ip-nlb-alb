module "aws-s3-encrypted-private" {
  source  = "Adaptavist/aws-s3-encrypted-private/module"
  version = "3.1.5"

  bucket_suffix                         = "${var.name}-nlb-config-${var.tags["Avst:Stage:Name"]}"
  use_bucket_suffix_as_name             = true
  kms_user_role_arns                    = [module.nlb-target-group-configurer.lambda_role_arn]
  kms_admin_role_arns                   = []
  enforce_server_side_encryption_header = false

  tags = var.tags
}