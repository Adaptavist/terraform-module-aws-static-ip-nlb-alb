resource "aws_eip" "elastic-ips" {
  # checkov:skip=CKV2_AWS_19:These EIPs will be attached to the NLB which is a valid use-case
  count            = length(var.public_subnets)
  vpc              = true
  tags = merge(var.tags, { "Avst:Service:Component" = "nlb-eip", "Name" = "nlb-eip" })
}