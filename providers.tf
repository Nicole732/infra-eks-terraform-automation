terraform {
  required_version = ">= 1.3"
  backend "s3" {
    bucket = "myapp-eks-terraform-state-732"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.67.0, < 5.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }
}

