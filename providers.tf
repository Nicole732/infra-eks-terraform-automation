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
      version = "~> 5.0" #">= 4.0, < 5.0" 
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.29.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11" # 2.11–2.13 are steady with EKS
    }


  }
}

