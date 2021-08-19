variable "private_subnets" {
  type        = list(string)
  description = "List of private subnet ids"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of public subnet ids"
}

variable "alb_sg_id" {
  type        = string
  description = "ALB security group id"
}

variable "tags" {
  type        = map(string)
  description = "Map of tags that should be applied to all resources"
}

variable "name" {
  type        = string
  description = "Solution name"
}

variable "deletion_protection_enabled" {
  type        = bool
  description = "Indicates if load balancers can be deleted"
}

variable "vpc_id" {
  type        = string
  description = "VPC that will host this solution"
}

variable "max_lookup_per_invocation" {
  default     = 50
  type        = number
  description = "The max times of DNS look per invocation."
}

variable "invocations_before_deregistration" {
  default     = 3
  type        = number
  description = "The number of required Invocations before an IP address is de-registered."
}
