output "internal_alb_arn" {
  value = aws_alb.private.arn
}

output "external_alb_arn" {
  value = aws_lb.nlb.arn
}

output "alb_dbs_name" {
  value = aws_alb.private.dns_name
}

output "nlb_target_group_arn" {
  value = aws_lb_target_group.nlb-default.arn
}