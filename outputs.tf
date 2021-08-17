output "internal_alb_arn" {
  value = module.load_balancers.internal_alb_arn
}

output "external_nlb_arn" {
  value = module.load_balancers.external_alb_arn
}