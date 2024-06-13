# Terraform Block
terraform {
  required_version = ">= 1.4" 
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.33"
    }
  }
  backend "s3" {
    bucket = "ali-zubair"
    key = "backed"
    region = "us-east-1"
    
  }
}

# Provider Block
provider "aws" {
  region  = "us-east-1"
}
/*
Note-1:  AWS Credentials Profile (profile = "default") configured on your local desktop terminal  
$HOME/.aws/credentials
*/
