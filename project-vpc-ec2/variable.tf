variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "CIDR block for the public subnets"
  type        = list(string)
}

variable "azs" {
  description = "list of availability zones"
  type        = list(string)
}

variable "traffic" {
  description = "CIDR block for the all traffic"
  type        = string
  default     = ""
}
