resource "aws_alb" "private" {
  # checkov:skip=CKV_AWS_150:not a company policy
  name                       = "${var.name}-private-alb"
  internal                   = true
  security_groups            = [var.alb_sg_id]
  subnets                    = var.private_subnets
  idle_timeout               = "50"
  drop_invalid_header_fields = true
  enable_deletion_protection = var.deletion_protection_enabled

  access_logs {
    bucket  = module.aws-s3-alb-logs.bucket_id
    prefix  = "private"
    enabled = true
  }

  tags = merge(var.tags, { "Avst:Service:Component" = "private-alb" })
}

resource "aws_lb" "nlb" {
  # checkov:skip=CKV_AWS_131:Skipping `Ensure that ALB drops HTTP headers` check. Only valid for Load Balancers of type application.
  # checkov:skip=CKV_AWS_150:not a company policy
  # checkov:skip=CKV2_AWS_28:not a company policy
  name               = "${var.name}-public-nlb"
  internal           = false
  load_balancer_type = "network"

  enable_deletion_protection       = var.deletion_protection_enabled
  enable_cross_zone_load_balancing = true

  access_logs {
    bucket  = module.aws-s3-alb-logs.bucket_id
    prefix  = "public"
    enabled = true
  }

  dynamic "subnet_mapping" {
    for_each = zipmap(var.public_subnets, aws_eip.elastic-ips.*.allocation_id)
    content {
      subnet_id     = subnet_mapping.key
      allocation_id = subnet_mapping.value
    }
  }

  tags = merge(var.tags, { "Avst:Service:Component" = "public-nlb" })
}

resource "aws_lb_target_group" "nlb-default" {
  name                 = "${var.name}-public-nlb-target-group"
  port                 = 443
  protocol             = "TCP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 15

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(var.tags, { "Avst:Service:Component" = "public-nlb-target-group" })
  depends_on = [
    aws_alb.private
  ]
}

resource "aws_lb_listener" "nlb-default" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    target_group_arn = aws_lb_target_group.nlb-default.arn
    type             = "forward"
  }
}
