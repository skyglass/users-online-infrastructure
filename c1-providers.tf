# Terraform Settings Block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.32.0"
    }
    helm = {
      source = "hashicorp/helm"
      #version = "2.6.0"
      version = "~> 2.6"
    }
    http = {
      source = "hashicorp/http"
      #version = "3.1.0"
      version = "~> 3.1"
    }    
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.13.1"
    }    
  }
  # Adding Backend as S3 for Remote State Storage
  backend "s3" {
    bucket = "skyglass-petclinic"
    key    = "dev/petclinic/terraform.tfstate"
    region = "eu-central-1" 
  }  
}

# Terraform Provider Block
provider "aws" {
  region = local.aws_region
}