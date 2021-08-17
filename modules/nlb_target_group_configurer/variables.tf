variable "tags" {
  type        = list(string)
  description = "List of tags that should be applied to all resources"
}

variable "namespace" {
  type        = string
  default     = null
  description = "Namespace, which could be project name or abbreviation"
}

variable "alb_dns_name" {
  type        = string
  description = "DNS name of the internal ALB"
}
variable "alb_listener_port" {
  type        = number
  description = "Internal ALB listener"
}
variable "nlb_target_group_arn" {
  type        = string
  description = "NLB Target group ARN"
}
variable "max_lookup_per_invocation" {
  default     = "50"
  description = "The max times of DNS look per invocation."
}
variable "invocations_before_deregistration" {
  default     = "3"
  description = "Then number of required Invocations before an IP address is deregistered."
}
variable "cw_metric_flag_ip_count" {
  description = "The controller flag that enables the CloudWatch metric of the IP address count."
  default     = "true"
}