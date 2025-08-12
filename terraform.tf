terraform {
  required_version = ">= 1.12.0, < 2.0.0" # Constrain Terraform CLI version

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # AWS provider constraint
    }
  }
}

provider "aws" {
  region = var.region
}
