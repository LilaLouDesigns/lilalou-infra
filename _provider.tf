terraform {
  required_version = "~> 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.56.0"
    }
  }
  backend "s3" {
    region = "ap-southeast-4"
    bucket = "terraform-state-lilalou"
    key    = "terraform.tfstate"
    dynamodb_table = "terraform-lock"
    encrypt = true
    skip_region_validation = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-4"
  # shared_config_files      = ["/Users/ngarampling/.aws/config"]
  # shared_credentials_files = ["/Users/ngarampling/.aws/credentials"]
  # profile                  = "terraform-lou"
}
