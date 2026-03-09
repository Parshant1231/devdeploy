terraform {
    required_version = ">= 1.3.0"

    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>5.0"
        }
        http = {
            source  = "hashicorp/http"
        }
    }
}

provider "aws" {
    region = var.aws_region
}