terraform {
  required_version = ">= 1.0"
  backend "s3" {
    bucket = "myapp-eks-terraform-state-732"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67" 
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20"
    }

      helm = {
      source = "hashicorp/helm"
      version = ">= 2.9, < 3.0"
    }

  }
}

