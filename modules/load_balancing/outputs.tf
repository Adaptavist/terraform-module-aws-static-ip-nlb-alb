output "internal_alb_arn" {
  value = aws_alb.private.arn
}

output "external_alb_arn" {
  value = aws_lb.nlb.arn
}

output "internal_alb_dns_name" {
  value = aws_alb.private.dns_name
}

output "internal_alb_zone_id" {
  value = aws_alb.private.zone_id
}

output "external_nlb_dns_name" {
  value = aws_lb.nlb.dns_name
}

output "external_nlb_zone_id" {
  value = aws_lb.nlb.zone_id
}

output "nlb_target_group_arn" {
  value = aws_lb_target_group.nlb-default.arn
}