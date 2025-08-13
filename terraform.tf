terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # AWS provider constraint
    }
  }
    backend "s3" {
    bucket         = "mern-terra-bucket-2025"
    key            = "terraform.tfstate"
    region         =  "us-west-2"
    dynamodb_table = "terraform-lock-table"
    
  }
}

provider "aws" {
  region = var.region
}
