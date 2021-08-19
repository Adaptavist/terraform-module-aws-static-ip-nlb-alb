module "load_balancers" {
  source = "./modules/load_balancing"

  name = var.name

  vpc_id          = var.vpc_id
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  alb_sg_id                   = var.alb_sg_id
  deletion_protection_enabled = var.deletion_protection_enabled

  tags = var.tags
}

module "nlb_configurer" {
  source = "./modules/nlb_target_group_configurer"

  name = var.name

  alb_arn              = module.load_balancers.internal_alb_arn
  nlb_arn              = module.load_balancers.external_alb_arn
  alb_dns_name         = module.load_balancers.internal_alb_dns_name
  alb_listener_port    = 443
  nlb_target_group_arn = module.load_balancers.nlb_target_group_arn

  invocations_before_deregistration = var.invocations_before_deregistration
  max_lookup_per_invocation         = var.max_lookup_per_invocation

  tags = var.tags
}

