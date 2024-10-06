remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "snaatak-p7-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "snaatak-p7-lock-table"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.38.0"  # Using a minimum version constraint
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"  
} 
EOF
}