provider "aws" {
  region = "${var.region}"
}

terraform {
    backend "s3" {
        encrypt = true
        region = "us-east-1"
        bucket = "dknopp-test-bucket"
        key = "terraform-state.tf"
    }
}