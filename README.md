# Provision EKS cluster with Secure Access Management

## Project Details
**Part 1**: Provision EKS cluster with Secure Access Management for developer and admin roles using Security Best Practices


## Table of contents

- [Technologies used](#Technologies-Used)
- [Project Description](#Project-Description)
- [Terraform Configuration](#Terraform-Configuration)
- [Contributors](#contributors)
- [Licensing](#licensing)

## Technologies Used
AWS EKS, AWS IAM, Terraform, Kubernetes

## Project Description:
**Part 1**
- Infrastructure as Code configuration to: Provision a base EKS cluster
    - Add Configuration for Access Management:
- Configure AWS IAM Roles for Access on AWS Level
    - Define Kubernetes Access with Role Based Access Control (RBAC) - creating K8s Roles and ClusterRoles
    - Configure Mapping between IAM Roles and K8s Users


## Terraform Configuration
- providers:
    - hashicorp/aws = 5.3
- modules:
    - terraform-aws-modules/vpc/aws ~> 5.0
    - terraform-aws-modules/eks/aws ~> 19.16
    
Terraform commands to execute the script:
- initialise project & download providers
    - *terraform init* 
- preview what will be created with apply & see if any errors
    - *terraform plan*
- exeucute with preview
    - *terraform apply -var-file terraform.tfvars*
- execute without preview
    - *terraform apply -var-file terraform.tfvars -auto-approve*
- destroy everything
    - *terraform destroy*
- show resources and components from current state
    - *terraform state list*

Notes: 
- Create terraform.tfvars file, make sure *.tfvars is in your .gitigonore file, and set following variables inside before running the script:
    - aws_access_key_id
    - aws_secret_access_key
    - aws_region
- For verbose output, set export TF_LOG=DEBUG before running TF commands

## Contributors

The contributors to this project are:
- [Tech World by NaNa](https://www.techworld-with-nana.com/devsecops-bootcamp) 

## Licensing

This program is free software: you can redistribute it and/or modify it under the terms of the [MIT license](LICENSE).
