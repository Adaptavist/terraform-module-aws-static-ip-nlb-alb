resource "aws_eip" "elastic-ips" {
  count            = length(var.public_subnets)
  vpc              = true
  public_ipv4_pool = "amazon"
}