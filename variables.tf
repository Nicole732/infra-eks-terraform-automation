variable "aws_region" {
  default = "us-east-1"
}

#variable "aws_access_key_id" {}
#variable "aws_secret_access_key" {}

variable "name" {
  default = "myapp-eks-2"
}

variable "k8s_version" {
  default = "1.33"
}

variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}
variable "private_subnet_cidr_blocks" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "public_subnet_cidr_blocks" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "tags" {
  default = {
    App = "eks-devsecops"
  }
}

# RBAC
variable "user_for_admin_role" {
  description = "The ARN of the user that will assume the admin role"
  type        = string
}
variable "user_for_dev_role" {
  description = "The ARN of the user that will assume the developer role"
  type        = string
}