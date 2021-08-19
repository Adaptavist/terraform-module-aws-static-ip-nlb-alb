output "internal_alb_arn" {
  value = module.load_balancers.internal_alb_arn
}

output "internal_alb_dns_name" {
  value = module.load_balancers.internal_alb_dns_name
}

output "internal_alb_zone_id" {
  value = module.load_balancers.internal_alb_zone_id
}

output "external_nlb_dns_name" {
  value = module.load_balancers.external_nlb_dns_name
}

output "external_nlb_zone_id" {
  value = module.load_balancers.external_nlb_zone_id
}

output "external_nlb_arn" {
  value = module.load_balancers.external_alb_arn
}