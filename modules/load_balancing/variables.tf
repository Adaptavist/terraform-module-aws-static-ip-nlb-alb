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