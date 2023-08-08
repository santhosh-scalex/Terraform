variable "region" {
  description = "The region where we setup our infra"
  type = string
}
variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "the name of the vpc"
  type = string
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type = string
}

variable "public_subnets" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
}
variable "database_subnets" {
  description = "CIDR blocks for the data subnets"
  type        = list(string)
}
variable "azs" {
  description = "List of availability zones"
  type        = list(string)

}
variable "tags" {
  description = "The tags to apply to the resources"
  type        = map(string)
}
