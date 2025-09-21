# mapping AWS IAM roles to K8s Roles in configmap aws-auth
locals {
  aws_k8s_role_mapping = [{
    rolearn  = aws_iam_role.external-admin.arn
    username = "admin"
    groups   = ["none"] #IF ["system:masters"] bad practice. avoid human user / read only permissions 
    },
    {
      rolearn  = aws_iam_role.external-developer.arn
      username = "developer"
      groups   = ["none"]
  }]
}

#AWS IAM Role for admin 
resource "aws_iam_role" "external-admin" {
  name = "external-admin"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  #who - authentication
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { # Reference to the AWS user that will use this role
          AWS = var.user_for_admin_role
        }
      },
    ]
  })
  #what - authorization
  inline_policy {
    name = "external-admin-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["eks:DescribeCLuster"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })

  }
}

#AWS IAM role for dev role
resource "aws_iam_role" "external-developer" {
  name = "external-developer"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  #who - authentication
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = { # Reference to the AWS user that will use this role
          AWS = var.user_for_dev_role
        }
      },
    ]
  })
  #what - authorization
  inline_policy {
    name = "external-admin-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action   = ["eks:DescribeCLuster"]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })

  }
}


