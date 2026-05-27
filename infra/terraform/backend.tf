/*
  Backend configuration example. For production use, configure an S3 backend
  with DynamoDB for state locking. This file is intentionally left as an
  example and commented out so `terraform init` will not fail.

  Example:

  terraform {
    backend "s3" {
      bucket         = "my-terraform-state-bucket"
      key            = "project/terraform.tfstate"
      region         = "eu-central-1"
      dynamodb_table = "terraform-locks"
      encrypt        = true
    }
  }
*/

