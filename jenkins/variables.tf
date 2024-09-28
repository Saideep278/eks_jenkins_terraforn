variable "vpc_cidr" {
  description = "vpc cidr"
  type = string
}

variable "public_subnets" {
  description = "subnets cidr"
  type = list(string)
}

variable "instance_type" {
  type = string
}