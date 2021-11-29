provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

terraform {
  required_version = "= 1.0.11"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.67.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "thenorthfork"
    workspaces {
      name = "img-upload-to-s3"
    }
  }
}
